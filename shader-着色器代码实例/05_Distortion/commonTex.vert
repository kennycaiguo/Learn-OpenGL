#version 400
#extension GL_ARB_separate_shader_objects : enable //����separate_shader_objects
#extension GL_ARB_shading_language_420pack : enable //����shading_language_420pack
layout (push_constant) uniform constantVals { //���ͳ�����
    mat4 mvp; //�ܱ任����
} myConstantVals;
layout (std140,set = 0, binding = 0) uniform bufferVals { //һ�¿�
    float ratio; //��תϵ��(����Ť���Ƕ�����)
} myBufferVals;
layout (location = 0) in vec3 aPosition; //����Ķ���λ��
layout (location = 1) in vec2 inTexCoor; //�������������
layout (location = 0) out vec2 outTexCoor; //�����ƬԪ��ɫ������������
out gl_PerVertex { //����ӿڿ�
    vec4 gl_Position; //�ڽ�����gl_Position
};
void main() {
    float pi = 3.1415926; //Բ���ʽ���ֵ
    float centerX=0.0; //���ĵ��X ����
    float centerY=-15; //���ĵ��Y ����
    float currX = aPosition.x; //��ǰ���X ����
    float currY = aPosition.y; //��ǰ���Y ����
    float spanX = currX - centerX; //��ǰX ƫ����
    float spanY = currY - centerY; //��ǰY ƫ����
    float currRadius = sqrt(spanX * spanX + spanY * spanY); //�������
    float currRadians; //��ǰ����X ��������ļн�
    if(spanX != 0.0){ //һ�����
    currRadians = atan(spanY , spanX);
    }else{ //�������
    currRadians = spanY > 0.0 ? pi/2.0 : 3.0*pi/2.0;
    }
    float resultRadians = currRadians + myBufferVals.ratio*currRadius; //�����Ť����ĽǶ�
    float resultX = centerX + currRadius * cos(resultRadians); //���������X ����
    float resultY = centerY + currRadius * sin(resultRadians); //���������Y ����
    outTexCoor = inTexCoor; //���䵽ƬԪ��ɫ������������
    gl_Position = myConstantVals.mvp * vec4(resultX,resultY,0.0,1.0); //���㶥������λ��
}
