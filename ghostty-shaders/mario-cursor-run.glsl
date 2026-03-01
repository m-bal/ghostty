// Mario runs from cursor+10 to end of screen, following cursor Y position
// Mario is sized to match the cursor

// --- Helper Macros & Functions ---
#define RGB(r, g, b) (vec3(r, g, b) / 255.0)
#define SPRITE_DEC( x, i ) mod( floor( i / pow( 4.0, mod( x, 8.0 ) ) ), 4.0 )

// --- Mario Drawing Function ---
vec4 getMarioPixel(vec2 uv, int frame_int) {
    float x = floor(uv.x * 16.0);
    float y = floor(uv.y * 16.0);
    float frame = float(frame_int);

    float idx = 0.0;

    if ( frame == 0.0 )
    {
        idx = y == 14.0 ? ( x <= 7.0 ? 40960.0 : 42.0 ) : idx;
        idx = y == 13.0 ? ( x <= 7.0 ? 43008.0 : 2730.0 ) : idx;
        idx = y == 12.0 ? ( x <= 7.0 ? 21504.0 : 223.0 ) : idx;
        idx = y == 11.0 ? ( x <= 7.0 ? 56576.0 : 4063.0 ) : idx;
        idx = y == 10.0 ? ( x <= 7.0 ? 23808.0 : 16255.0 ) : idx;
        idx = y == 9.0 ? ( x <= 7.0 ? 62720.0 : 1375.0 ) : idx;
        idx = y == 8.0 ? ( x <= 7.0 ? 61440.0 : 1023.0 ) : idx;
        idx = y == 7.0 ? ( x <= 7.0 ? 21504.0 : 793.0 ) : idx;
        idx = y == 6.0 ? ( x <= 7.0 ? 22272.0 : 4053.0 ) : idx;
        idx = y == 5.0 ? ( x <= 7.0 ? 23488.0 : 981.0 ) : idx;
        idx = y == 4.0 ? ( x <= 7.0 ? 43328.0 : 170.0 ) : idx;
        idx = y == 3.0 ? ( x <= 7.0 ? 43584.0 : 170.0 ) : idx;
        idx = y == 2.0 ? ( x <= 7.0 ? 10832.0 : 42.0 ) : idx;
        idx = y == 1.0 ? ( x <= 7.0 ? 16400.0 : 5.0 ) : idx;
        idx = y == 0.0 ? ( x <= 7.0 ? 16384.0 : 21.0 ) : idx;
    }
    else if ( frame == 1.0 )
    {
        idx = y == 15.0 ? ( x <= 7.0 ? 43008.0 : 10.0 ) : idx;
        idx = y == 14.0 ? ( x <= 7.0 ? 43520.0 : 682.0 ) : idx;
        idx = y == 13.0 ? ( x <= 7.0 ? 54528.0 : 55.0 ) : idx;
        idx = y == 12.0 ? ( x <= 7.0 ? 63296.0 : 1015.0 ) : idx;
        idx = y == 11.0 ? ( x <= 7.0 ? 55104.0 : 4063.0 ) : idx;
        idx = y == 10.0 ? ( x <= 7.0 ? 64832.0 : 343.0 ) : idx;
        idx = y == 9.0 ? ( x <= 7.0 ? 64512.0 : 255.0 ) : idx;
        idx = y == 8.0 ? ( x <= 7.0 ? 25856.0 : 5.0 ) : idx;
        idx = y == 7.0 ? ( x <= 7.0 ? 38208.0 : 22.0 ) : idx;
        idx = y == 6.0 ? ( x <= 7.0 ? 42304.0 : 235.0 ) : idx;
        idx = y == 5.0 ? ( x <= 7.0 ? 38208.0 : 170.0 ) : idx;
        idx = y == 4.0 ? ( x <= 7.0 ? 62848.0 : 171.0 ) : idx;
        idx = y == 3.0 ? ( x <= 7.0 ? 62976.0 : 42.0 ) : idx;
        idx = y == 2.0 ? ( x <= 7.0 ? 43008.0 : 21.0 ) : idx;
        idx = y == 1.0 ? ( x <= 7.0 ? 21504.0 : 85.0 ) : idx;
        idx = y == 0.0 ? ( x <= 7.0 ? 21504.0 : 1.0 ) : idx;
    }
    else // frame == 2.0
    {
        idx = y == 15.0 ? ( x <= 7.0 ? 43008.0 : 10.0 ) : idx;
        idx = y == 14.0 ? ( x <= 7.0 ? 43520.0 : 682.0 ) : idx;
        idx = y == 13.0 ? ( x <= 7.0 ? 54528.0 : 55.0 ) : idx;
        idx = y == 12.0 ? ( x <= 7.0 ? 63296.0 : 1015.0 ) : idx;
        idx = y == 11.0 ? ( x <= 7.0 ? 55104.0 : 4063.0 ) : idx;
        idx = y == 10.0 ? ( x <= 7.0 ? 64832.0 : 343.0 ) : idx;
        idx = y == 9.0 ? ( x <= 7.0 ? 64512.0 : 255.0 ) : idx;
        idx = y == 8.0 ? ( x <= 7.0 ? 42320.0 : 5.0 ) : idx;
        idx = y == 7.0 ? ( x <= 7.0 ? 42335.0 : 16214.0 ) : idx;
        idx = y == 6.0 ? ( x <= 7.0 ? 58687.0 : 15722.0 ) : idx;
        idx = y == 5.0 ? ( x <= 7.0 ? 43535.0 : 1066.0 ) : idx;
        idx = y == 4.0 ? ( x <= 7.0 ? 43648.0 : 1450.0 ) : idx;
        idx = y == 3.0 ? ( x <= 7.0 ? 43680.0 : 1450.0 ) : idx;
        idx = y == 2.0 ? ( x <= 7.0 ? 2708.0 : 1448.0 ) : idx;
        idx = y == 1.0 ? ( x <= 7.0 ? 84.0 : 0.0 ) : idx;
        idx = y == 0.0 ? ( x <= 7.0 ? 336.0 : 0.0 ) : idx;
    }

    float color_index = SPRITE_DEC(x, idx);

    vec3 color = vec3(0.0);
    float alpha = 0.0;
    if (color_index > 0.0) {
        alpha = 1.0;
        color = color_index == 1.0 ? RGB( 106, 107,  4 ) : color; // Brown
        color = color_index == 2.0 ? RGB( 177,  52, 37 ) : color; // Red
        color = color_index == 3.0 ? RGB( 227, 157, 37 ) : color; // Skin
    }

    return vec4(color, alpha);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec4 terminalColor = texture(iChannel0, uv);

    // --- Animation ---
    const int totalFrames = 3;
    float animationSpeed = 8.0;
    int currentFrame = int(mod(iTime * animationSpeed, float(totalFrames)));

    // --- Cursor info ---
    // iCurrentCursor.xy = left, top corner in pixels (same space as fragCoord, +Y up)
    // iCurrentCursor.zw = width, height in pixels
    vec2 cursorPosUV = iCurrentCursor.xy / iResolution.xy;   // .y = top of cursor
    vec2 cursorSizeUV = iCurrentCursor.zw / iResolution.xy;
    float cellWidthUV = iCurrentCursor.z / iResolution.x;

    // Cursor bottom in UV space (top minus height, since +Y is up)
    float cursorBottomY = cursorPosUV.y - cursorSizeUV.y;

    // --- Mario size: 1.5x the cursor, square aspect ---
    float scale = 1.5;
    float marioH = cursorSizeUV.y * scale;
    vec2 marioSize = vec2(marioH * (iResolution.y / iResolution.x), marioH);

    // --- Run range ---
    // Start: 10 cell widths to the right of cursor
    float startX = cursorPosUV.x + 10.0 * cellWidthUV;
    // End: right edge minus mario width
    float endX = 1.0 - marioSize.x;
    float runDistance = max(endX - startX, 0.001);

    // --- Mario X position: animate and loop ---
    float runSpeed = 0.15;
    float marioX = startX + mod(iTime * runSpeed, runDistance);

    // --- Mario Y position: vertically centered on cursor row ---
    float marioY = cursorBottomY + (cursorSizeUV.y * 0.5) - (marioSize.y * 0.5);

    vec2 marioPos = vec2(marioX, marioY);

    // --- Draw Mario ---
    if (uv.x > marioPos.x && uv.x < marioPos.x + marioSize.x &&
        uv.y > marioPos.y && uv.y < marioPos.y + marioSize.y)
    {
        vec2 localUV = (uv - marioPos) / marioSize;
        localUV.y = 1.0 - localUV.y;

        vec4 marioColor = getMarioPixel(localUV, currentFrame);

        if (marioColor.a > 0.0) {
            fragColor = marioColor;
        } else {
            fragColor = terminalColor;
        }
    }
    else
    {
        fragColor = terminalColor;
    }
}
