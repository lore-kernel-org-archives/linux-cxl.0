Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2722B17BA1
	for <linux-cxl@vger.kernel.org>; Mon,  8 Apr 2024 06:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712556791; cv=none; b=VgZo40OW/bS1uZpAMweET+0X6ASWaz3JDgtqzy8+1lNRae1FWd8wrd2anlnJyyxSkuHlw5oFMGj2jq3jIwLuGjvs5drXKCcgIEjOriRGFDSga/JOAU0A/Gz1X2NcjujPjZxCKe4oXvOdd8QrF9Jb6ovbFKsAPVjJSVX3s7yp4YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712556791; c=relaxed/simple;
	bh=Qzs2Bo1TPhCr5OOsDX6wjKELhzHAXodyj7AaORSjN2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUSqzJBL9bx/UKlHLEkaqNkQnDO7Q/BWY8xcJZnUxW30JUUFlnG78N2520Ik9GOhvhJWEDSnwbnBN7Q+4288Zf9wg6vu9HkUKU2V7WtXlWD3NE4GYNzzmhmFFBfxWSiVPzoFHyGAJMNN3Qgvw6Z2XTZJtxeHebjYnBv6ym0+g2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TrnYhBOA; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TrnYhBOA"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so988292a12.0
        for <linux-cxl@vger.kernel.org>; Sun, 07 Apr 2024 23:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712556788; x=1713161588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yyVXW/tOOcf178Yz/V/TmnBdgySH90rpKbBwDkRWcg8=;
        b=TrnYhBOAhYQhfn8pQQBwhWC8F8aw4gReD+3WpZOQVUQCyp90TtQNUCHVkMh+9rfKpW
         hKJbfRUuPvFkyvX4HSkFpZ939iKkiE8OqQ73SBwtwgV/rIDEU6TQvh77wGj7abrP3EE9
         lQskFCuDcTmuNIskJHhD1LZLhaOsZqoiJtiKtLNg031AodMATW0vQ/GjJicpZ7qb2wHU
         ZDys74f5ien4yVWQNOKMrBw2awEsmwD0pT3g9wNk6uh7TQg7+hgMETCteWol0fHa/11u
         uHel4js/qj2UHqPW+faJIyr245ZxMx0KBJ+n/rW/oP50AnqJx8XXMRi5Aq63WnNRt0gg
         UDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712556788; x=1713161588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yyVXW/tOOcf178Yz/V/TmnBdgySH90rpKbBwDkRWcg8=;
        b=d/lKfdJdTfrdrOSOUErjp2QD0saa7VZSsDfCAvf+RzrP4itWyjRIaTbsxRmWRiqUcM
         ASRHmY6Cd5BDJ/m124ZL1wqRouULePc2UAcrt/jUik30f7gVb5q+J765KXr/vsxLiUhD
         mQciDHPLW+tp/k2bU0pwd7S6wvxNv/IrKWfabjh4cZ0ulE/cQOkU4lLPC1LCXKyLqJhJ
         H1AU6gApJgZwy/W6iFXizM00tN0ooby8/2XO0FJmLjnsvNZS5lRbhRmSTjFievuNWM0z
         LAZJTDsnXpzWrDYhFyt6mDcZprERvsXGNOdriQ0g2QtFgzKxhbWayI9FjhYg24gfdk6T
         i5vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgN58/XHEkiNO2WLe4uvZIXwYQWaiuNnoUSx7mX9PntBnnjW0iP5qsiJ9sT8hUXFxo+Ii/ye6W8ohlnX0drv3HSO5vSCPbcHvw
X-Gm-Message-State: AOJu0Yxpar6jUX7w8m9EAW2/DQlgFHY/USu77ueGyqzoyGdibFEue22A
	aBFGZDnnbxPRfJcSgTde1cO8rQR7womPCNWvWn9rcfZkPeFpLjS/o/Uf+i0JzUU=
X-Google-Smtp-Source: AGHT+IHLe236STgkc0K97DkpWNrjCr0nGKvr+Cpxm1ntbJYrS9+Iqdo5GyxZJblU5FqKxteaTLyr/g==
X-Received: by 2002:a17:907:6d0a:b0:a51:a259:a796 with SMTP id sa10-20020a1709076d0a00b00a51a259a796mr6602519ejc.56.1712556788525;
        Sun, 07 Apr 2024 23:13:08 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
        by smtp.gmail.com with ESMTPSA id el1-20020a170907284100b00a51ce6730b5sm1546216ejc.84.2024.04.07.23.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 23:13:08 -0700 (PDT)
Message-ID: <d17878e8-91c4-4628-9be0-43261ca35b50@linaro.org>
Date: Mon, 8 Apr 2024 08:13:06 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] tcg: Add TCGContext.emit_before_op
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406223248.502699-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/4/24 00:32, Richard Henderson wrote:
> Allow operations to be emitted via normal expanders
> into the middle of the opcode stream.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h |  6 ++++++
>   tcg/tcg.c         | 14 ++++++++++++--
>   2 files changed, 18 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

