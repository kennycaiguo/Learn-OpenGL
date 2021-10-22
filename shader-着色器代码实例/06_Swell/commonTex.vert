#version 400
#extension GL_ARB_separate_shader_objects : enable //����separate_shader_objects
#extension GL_ARB_shading_language_420pack : enable //����shading_language_420pack
layout (push_constant) uniform constantVals { //���ͳ�����
    mat4 mvp; //�ܱ任����
} myConstantVals;
layout (std140,set = 0, binding = 0) uniform bufferVals { //һ�¿�
    float uFatFactor; //��������ϵ��
} myBufferVals;
layout (location = 0) in vec3 pos; //����Ķ���λ��
layout (location = 1) in vec2 inTexCoor; //�������������
layout (location = 2) in vec3 inNormal; //����Ķ��㷨����
layout (location = 0) out vec2 outTexCoor; //�����ƬԪ��ɫ������������
out gl_PerVertex { //����ӿڿ�
    vec4 gl_Position; //�ڽ�����gl_Position
};
void main() {
    outTexCoor = inTexCoor; //�����ƬԪ��ɫ������������
    gl_Position = myConstantVals.mvp* vec4(pos+inNormal*myBufferVals.uFatFactor,1.0); //���ݴ�������ϵ�����㶥������λ��
}
