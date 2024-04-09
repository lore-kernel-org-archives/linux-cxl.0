Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E1113541F
	for <linux-cxl@vger.kernel.org>; Tue,  9 Apr 2024 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676501; cv=none; b=qTafGTijfENVpIK5G47VfQEvVqb/f1hE1UfWNfzLYuALKUDeACpCKyS5hKhPhSbEQLKVxaX6mlOWm6Y65aXXZ6gOexoqu+rT9OR32W9+JdJ4qXQMbzoBieEQ/vD6dCNg1cY/c5kO0KEumkFRww+LrpMf9CE1GuxO0TaNJos9oLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676501; c=relaxed/simple;
	bh=kyK0k0ci0JW3RPu9xopHjuhONWCCD/EdhCcl8mBHIzw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A94PTBQ8s859PeBZ7r9HUGHYNaJAS3nmX0WRJjMATCRZ8chskcZ8vR34Iglp0+2M+II1N+6iL57mlnMV+OBUneZhexgMSK0eWjXQGo47BNksyN/HTPpXF3RqxuUV3BVujVDBt0nypZyj+wb6tRsA4d/18KuQMlIzi8JexaghLL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LhPZlTMb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LhPZlTMb"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51fea60c0bso78454766b.3
        for <linux-cxl@vger.kernel.org>; Tue, 09 Apr 2024 08:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712676498; x=1713281298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YcuDfxLS/17fvdj4MOOhMrE9s0vfY1BZzacqaws/XZ4=;
        b=LhPZlTMbc86XkBsEEZQVc0jqEOFxhG1RW+VprljWiMWCsFcSlAi2/J4sQjIZ3J6ETg
         8uJMNqZ4ekFNjVparxKZbGJoAwWfn+kRttBm/vEomTSHvcOVZ39/cUEoS0UaowRVxpKJ
         jaE8sSGTb6u00WNl2DegqdwhAGBvuGl3wxCBJHxIPRhvfPj9ZEGbJjas3SrW+o69mIhU
         6hMWtmvmWCLJhElFgUSgKBBtjCbo8P+2bGP4JnxCOglMi+qS7aQu/ivP6/jYFa3lbBSs
         lwjRpQ/dGeZ+xwuvGvRlckG+ogM13OHE54Z2YJebfiLV6sQEu2byZw8duZNFOMWrYdLw
         sv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676498; x=1713281298;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcuDfxLS/17fvdj4MOOhMrE9s0vfY1BZzacqaws/XZ4=;
        b=wRfGyMAUUzkfcPDPdfKBG3fDF7s5A6eAegsXYYZfG/0GdyILrnoyWCBLB83eqxFLCB
         uUK8evAOpLG8d9yBsMe8hmg3lBHd7mM8i+yMRFjN+8a0Y94PtmuuMi6JRBFzSyVWGyQq
         5VpWvmfA97s4yQ4yIBkhIY7UW1/IXAS6WZ7q56ttbNH5OU8xFZjiDH1bBjMtQtctyrdQ
         u/sLnuskNyWjDOAizvatMZ1+wJFxKzwNrGbatKIZPj1QAkPGUe36THPnRO0iHx0HqkM2
         YV3YHI7KvWo6cL6foCNDCREQpGzjW/ft4xR+cLQIzOVmCVsEonMlcT8gSVAHlfMgonYY
         3wHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFCHLwbC2aeFC1+THZKpXjq+T5YYggg2aSjItZSY++yZ5zaBixSeESGepkNQ8iG9S7v0Cv5dQraB74KJIOUUC4Lfoq4lgUVnD+
X-Gm-Message-State: AOJu0YxpTdt1x1goZuMTvO5Wx+kHD4qdWPmwd0Ax5TdWoHKrqSGXFpsc
	04RvN/jNngATK+oLovtOx41KEkKzJjKuwDwuA9hsi4kaXR36uIOcDAKKfjAEZKU=
X-Google-Smtp-Source: AGHT+IG6+HiUVr1zn4mni0ZrsJ8GBOvRbjLaGJxDvPNdXnpVoLIP+ndRrPCGTQKztsjgDgfoxfG0mw==
X-Received: by 2002:a17:906:da8d:b0:a51:c1e0:3049 with SMTP id xh13-20020a170906da8d00b00a51c1e03049mr8410189ejb.12.1712676498282;
        Tue, 09 Apr 2024 08:28:18 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.160.134])
        by smtp.gmail.com with ESMTPSA id e9-20020a17090618e900b00a4655513f0bsm5807113ejf.88.2024.04.09.08.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 08:28:17 -0700 (PDT)
Message-ID: <99e4fb4a-6248-46fa-8e6e-ed767c3f771e@linaro.org>
Date: Tue, 9 Apr 2024 17:28:16 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] target/i386: Preserve DisasContextBase.insn_start
 across rewind
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-6-richard.henderson@linaro.org>
 <c1cc9fac-f227-434e-a0b5-d4826f26c9a5@linaro.org>
Content-Language: en-US
In-Reply-To: <c1cc9fac-f227-434e-a0b5-d4826f26c9a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/24 17:23, Philippe Mathieu-Daudé wrote:
> On 7/4/24 00:32, Richard Henderson wrote:
>> When aborting translation of the current insn, restore the
>> previous value of insn_start.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/i386/tcg/translate.c | 3 +++
>>   1 file changed, 3 insertions(+)
> 
> 
>> @@ -3123,6 +3124,7 @@ static bool disas_insn(DisasContext *s, CPUState 
>> *cpu)
>>           /* END TODO */
>>           s->base.num_insns--;
>>           tcg_remove_ops_after(s->prev_insn_end);
>> +        s->base.insn_start = s->prev_insn_start;
>>           s->base.is_jmp = DISAS_TOO_MANY;
>>           return false;
>>       default:
>> @@ -6995,6 +6997,7 @@ static void i386_tr_insn_start(DisasContextBase 
>> *dcbase, CPUState *cpu)
>>       DisasContext *dc = container_of(dcbase, DisasContext, base);
>>       target_ulong pc_arg = dc->base.pc_next;
>> +    dc->prev_insn_start = dc->base.insn_start;
>>       dc->prev_insn_end = tcg_last_op();
>>       if (tb_cflags(dcbase->tb) & CF_PCREL) {
>>           pc_arg &= ~TARGET_PAGE_MASK;
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

And:
Tested-by: Jørgen Hansen <Jorgen.Hansen@wdc.com>
(also to patches 1 & 2)

:)
