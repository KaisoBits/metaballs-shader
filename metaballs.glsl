precision highp float;

#define BALL_COUNT 3

uniform float time;
uniform vec2 resolution;

struct Ball
{
  vec2 pos;
  vec3 color;
  float radius;
};


void main( void ) 
{
  float resolutionRatio = resolution.x / resolution.y;
  
  vec2 fragPos = vec2(gl_FragCoord.x / resolution.x - 0.5, (gl_FragCoord.y / resolution.y - 0.5) / resolutionRatio);
	
  Ball balls[BALL_COUNT];
  balls[0] = Ball(vec2(sin(time) / 8.0), vec3(0.3, 0.2, 1.0), 0.05);
  balls[1] = Ball(vec2(-sin((time + 1.2)*1.3) / 8.0, sin((time + 3.8)*1.3) / 8.0), vec3(0.3, 0.5, 0.8), 0.04);
  balls[2] = Ball(vec2(-sin((time + 0.2)*2.3) / 8.0, sin((time + 1.2)*1.7) / 10.0), vec3(0.8, 0.2, 0.2), 0.045);
	
  vec3 colorSum = vec3(0);
  float alphaSum = 0.0;
  for (int i = 0; i < BALL_COUNT; i++)
  {
    float a = min(balls[i].radius / distance(balls[i].pos, fragPos), 1.0);
    colorSum += (balls[i].color * a);
    alphaSum += a;
  }

  if (alphaSum >= 0.9)
    gl_FragColor = vec4(colorSum / alphaSum, alphaSum);	 
  else
    gl_FragColor = vec4(0.0);
	 
}