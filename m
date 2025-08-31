Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BED622F14D;
	Sun, 31 Aug 2025 23:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756681652; cv=none; b=jhtn7XxICT1D1cus1Ng6zvESwyfn63NTkZ6KI+NLvZzpleRx05LrpZKtUHn1mPokxELYXlq1G7XKP/MIeUcehihOQSocZF3NKQqFz8oBJF76eyWOiQYMRNYR4QIskych98o2QdkbZ7bcJ0YzNyFv9EwYmIK1NCDoeoVAmCmyUZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756681652; c=relaxed/simple;
	bh=/dq1+WkskxLjQfiUna2tnvXAStsMIRt3sNeqPiyojaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qto1ZMax0O2+xWctoDL9zulYabtfvMVd2XLt+t2jqLUhFeLMoZGjUj5IwPi+wCiefj16sjKefI/ziEfRUZ+DWQvDn1u2zj/aAKMUJbwjtqjGqKpI3eoB3nq2zHDAnwy5NsR0YYN5RbbBGCD2UQxAov36dy8IT+3ums3OzvfvZCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWniY+gM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWniY+gM"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b8b2712d8so7041875e9.3;
        Sun, 31 Aug 2025 16:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756681649; x=1757286449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VzORTaj5j85cq2M8IR2sPPrrk6vTYoFG53BsY3IwtmU=;
        b=RWniY+gM5NFbvvK6Kw+NYWL+uBRJJIIeR277NLFyk1mj5SBKK5GtZzVwGrD+tUUD2R
         /2KEQbWGt3xMtek1FpIsRgjjvEo0CaL3K3ojtYcrFhiAv5j8+0/l1cCA87mX0irnScHm
         AN0yvkVFCuwPtZS3JjkXr3fOQmQUIIxHEL37SKx5I/Lb1kwGdVIw4N/fFfLYEnWgCxoA
         u0W8VWU94/sm4fnDphjReKQL8YanvFj75sHNSzRzmyqYAKWfhf1ArKcefvcFn9+vXot2
         s9NB+o5lmI9BGIbtmBFrROXwBXNiszQT3/mw9wrVDrfJ6TyqkNycycJmVIrpuRWye9qe
         YsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756681649; x=1757286449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VzORTaj5j85cq2M8IR2sPPrrk6vTYoFG53BsY3IwtmU=;
        b=KhjRU6YjFyVbJWs4+BcJIcqX6sS/uvxsPswejlpP/nf9OmRdb3cCQoviXViMbRV9pX
         XmDYhP/MbCTMuMe+MSjj8pOdrrWIC5rHeFT3RchwP0y9PqO8/VN7RBlYa7MHyeJpMJkV
         LZNY2oWMTq4tXuC2PUyk8mwaJYhYcyhXVj53yTTwB2rFRl+i9VSiSETYGXkX6FlBlvnX
         Qe4c9lIn9ychfLhQu+dka1RQxFCj69iBHQbCbuQac/H4X9QcHsgOAJrsIpgzF4XbLaRq
         5FDIHDejKPYAUGiej1mp1WB4i9zp15inQu4urs4GHQ2ysv41dHdlDDvCSdqnQ2DM2xpV
         2SOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAziffEwyxRYgoMIXWzRFbqRa61u1szZ4CBKdN7zvwGwgqLtzzwdqtEPR/nePpKPNfLtoYIyZ9Ug4=@vger.kernel.org, AJvYcCWIVsZLuv/60kCUfW77mODB2ln8l5nVosD+8qamFrNNhG5xzuRPdojqbxlnmDRR5YEy2M05XBuoXtSLDUGC@vger.kernel.org
X-Gm-Message-State: AOJu0YwfjfQEL2GNVT7npqOJzz/qsVoFVhflFqQ4mO1y5vbm6RO6stJj
	sxn9awldaTcL/VTjPELU1lvFXpis7HQ9xp6qB63O/EgAutgxKKnJNb90
X-Gm-Gg: ASbGnctXEFbJx7fiffX38vnZMJwUTSp918TrVLUhNqTu7lCEuOE/WUq1YdCS/ezYO/w
	W8Tqimdmk9ry9mJr/CnJ9TyRqMCp++YveP/7ISZyRiBuox6ySMRYk1zvUDlKsnLgthb/2s7OL5c
	MJdD5tY4ohFXMEX+2781SSm+6G5wnM0Zv0rkGg0ynuvnu37HdxDCtktZ1XAaG+Ic79G4udwy5ec
	ULY03sOQjn3lBvmauAUjNYjBjSGQEUaIo86G20m7lZxhMi69M1j/ru5Mfg2AmADTVHFVUNAAEl6
	T5bzp1dU/2X8yQuyQQBICTjqw+0YQpBBJhC30+GUQbPgO+wzz0wzDYvdounC4/M4K3ojYaA7czf
	NF6HL1zkkTSfmTUU1rwHm15RnsjU/56JyKCaN9SZjrw==
X-Google-Smtp-Source: AGHT+IEvc7GiBSOLL0eVIAnfsFxuuyb9Xs6ZWQt1q85vQuVTGCKCiLZUHxhq+3aytM1K0vb5VJdtTQ==
X-Received: by 2002:a05:600c:5487:b0:45b:8d2a:ccfe with SMTP id 5b1f17b1804b1-45b8d2acf6dmr7011485e9.13.1756681649334;
        Sun, 31 Aug 2025 16:07:29 -0700 (PDT)
Received: from [192.168.100.24] ([102.31.181.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e74b72esm133792415e9.0.2025.08.31.16.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 16:07:28 -0700 (PDT)
Message-ID: <c6158f58-7a62-4df3-b025-4fe9f33c4d16@gmail.com>
Date: Mon, 1 Sep 2025 00:07:26 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/driver-api: Fix typo error in cxl
To: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Gregory Price <gourry@gourry.net>,
 Alok Tiwari <alok.a.tiwari@oracle.com>,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org
References: <20250819084116.13108-1-smokthar925@gmail.com>
 <87iki53gfb.fsf@trenco.lwn.net>
Content-Language: en-US
From: Moktar sellami <smokthar925@gmail.com>
In-Reply-To: <87iki53gfb.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/29/25 23:35, Jonathan Corbet wrote:
> Moktar SELLAMI <smokthar925@gmail.com> writes:
>
>> Fixed Typo in the driver-api/cxl/devices/devices.rst
>>
>> functionalty -> functionality
>>
>> Signed-off-by: Moktar SELLAMI <smokthar925@gmail.com>
>> ---
>>   Documentation/driver-api/cxl/devices/device-types.rst | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/driver-api/cxl/devices/device-types.rst b/Documentation/driver-api/cxl/devices/device-types.rst
>> index 923f5d89bc04..7f69dfa4509b 100644
>> --- a/Documentation/driver-api/cxl/devices/device-types.rst
>> +++ b/Documentation/driver-api/cxl/devices/device-types.rst
>> @@ -22,7 +22,7 @@ The basic interaction protocol, similar to PCIe configuration mechanisms.
>>   Typically used for initialization, configuration, and I/O access for anything
>>   other than memory (CXL.mem) or cache (CXL.cache) operations.
>>   
>> -The Linux CXL driver exposes access to .io functionalty via the various sysfs
>> +The Linux CXL driver exposes access to .io functionality via the various sysfs
>>   interfaces and /dev/cxl/ devices (which exposes direct access to device
>>   mailboxes).
> This one was fixed a while back, so this patch is not needed.  It is
> always a good idea to check linux-next when considering changes of this
> type.
>
> Thanks,
>
> jon

Thank you for the clarification and for pointing me to linux-next. i 
will try to come up with an other patch thank u.

Moktar


