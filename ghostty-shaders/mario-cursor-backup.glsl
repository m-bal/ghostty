// Procedural running Mario shader for Ghostty - Cursor Following Version

// --- Helper Macros & Functions ---
#define RGB(r, g, b) (vec3(r, g, b) / 255.0)

// The user-provided, correct macro for decoding the sprite data.
#define SPRITE_DEC( x, i ) mod( floor( i / pow( 4.0, mod( x, 8.0 ) ) ), 4.0 )

vec2 normalize_coord(vec2 value, float isPosition) {
    return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
}

// --- Mario Drawing Function (Using the correct decoding logic) ---
vec4 getMarioPixel(vec2 uv, int frame_int) {
    // Convert normalized UVs [0,1] to integer pixel coordinates [0,15]
    float x = floor(uv.x * 16.0);
    float y = floor(uv.y * 16.0);
    float frame = float(frame_int);

    float idx = 0.0; // This will hold the bitmask for the current row.

    // This is the Shadertoy code you provided, which selects the correct bitmask.
    if ( frame == 0.0 )
    {
        idx = y == 14.0 ? ( x <= 7.0 ? 40960.0 : 42.0 ) : idx;
        idx = y == 13.0 ? ( x <= 7.0 ? 43008.0 : 2730.0 ) : idx;
        idx = y == 12.0 ? ( x <= 7.0 ? 21504.0 : 223.0 ) : idx;
        idx = y == 11.0 ? ( x <= 7.0 ? 56576.0 : 4063.0 ) : idx;
        idx = y == 10.0 ? ( x <= 7.0 ?
