Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DA531725
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mlCrJFMM"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e3b3fb6f6so2452755e9.2
        for <linux-cxl@vger.kernel.org>; Fri, 05 Jan 2024 08:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704473198; x=1705077998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+XesGPt6M8kow2hbHLuoiYwZT9fbHdGsS/st+N6yU4=;
        b=mlCrJFMMSVnhc1enQAcSVLX3tEx2ymLZDQH+FntIExyy860TVcKuyyWFpoJ77JMBhH
         3sn+Zran9wccF2mAlWcPdzDtoMUlMlRHatIrnrIPCwwEW6LYaio4ecGdREl5cjMVaR79
         JMMMqCtiPjvkjwvyNrV8pVknzp9fNPDE1fV7+8mgLBw3P2K5m/VDFKuHEqc5OaCW/pIW
         BVaWOCOWd+N/a4WFbxTcwVS3O02Gp2iaLSxo0X0KvrU+YYYTN2+ANGcgeEeOdgEG3zwm
         XwmnUk1PSqJnd6PaSUbTn3TMZz5a2dghf3f952Tua244HcWxb0VN/1pAhWRdA1gWGObT
         Gz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704473198; x=1705077998;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y+XesGPt6M8kow2hbHLuoiYwZT9fbHdGsS/st+N6yU4=;
        b=BCh2oqDZvK/dOzQWtYMKe42w2mCWRqt2YEb0fAzHOCmLa/EC2u3MQ+5HaZi7FdOCl1
         rtyaSMT0zSXCC+zLdSWVlFgLwWYy3BbvN+VS3C7f5D21zdx/QuS4xfQn2+m5Cni05N/1
         mmhgQr7Qq92djnz13b4H3m8WdP6DtcBYc5ghAawaag5OAINi7TKGmwPy8LAZjlNyzbHN
         cB0VkmmXQ6/u02iHUKnh7gwfXSPWa6pnM6CwfXBWyX2KCV7fPYLyjxT0xl/+nQQa3oeS
         l5W/yk9+MhQ8yIZnYNXdDzHtgRPKUF1naxCj63FxjH3tW2Llc4gmtHhWLO1u1fXaoaGF
         k54g==
X-Gm-Message-State: AOJu0Yzx3T9QzgWQ1qzCN4sSbB2VnVj5B/6So9ZoaeIZaS1MkDXwMebv
	Btot79npey4104NuJCEyf89/UZ4Idq8nuQ==
X-Google-Smtp-Source: AGHT+IGfQ3Xtijrn9RSjx5/lkQi003txpkqHMJPrjO3j7ymH6H2sBW6JG409QE8qxnBxTKL1vsQOww==
X-Received: by 2002:a05:600c:a42:b0:40d:8780:2aff with SMTP id c2-20020a05600c0a4200b0040d87802affmr1276841wmq.131.1704473198281;
        Fri, 05 Jan 2024 08:46:38 -0800 (PST)
Received: from draig.lan ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id h14-20020adfe98e000000b003367a51217csm1706264wrm.34.2024.01.05.08.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 08:46:38 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id AB8E75F933;
	Fri,  5 Jan 2024 16:46:37 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?B?5ZGo56ul?= <273415826@qq.com>
Cc: "qemu-devel" <qemu-devel@nongnu.org>,  "linux-cxl"
 <linux-cxl@vger.kernel.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: Question about CXL emulation in QEMU
In-Reply-To: <tencent_7710D323F3DCBEF4BEAAF17BB3AF851D4707@qq.com>
 (=?utf-8?B?IuWRqOerpSIncw==?=
	message of "Fri, 5 Jan 2024 19:00:14 +0800")
References: <tencent_7710D323F3DCBEF4BEAAF17BB3AF851D4707@qq.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 05 Jan 2024 16:46:37 +0000
Message-ID: <87r0iveniq.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"=E5=91=A8=E7=AB=A5" <273415826@qq.com> writes:

> Dear Experts,

(add maintainers to CC)

>
> I am writing to seek your assistance about CXL emulation in QEMU. I am Zh=
ou Tong and I am researching how to use QEMU
> to simulate CXL over Ethernet=E3=80=82
>
> I want to implement remote registration of CXL.mem devices based on the Q=
OM model. The general idea is: the CXL slave
> side notifies the master side of the size of the CXL memory and other con=
trol information through Ethernet, and the master
> side registers the CXL device locally based on the control information. W=
hen the master accesses the CXL device, KVM is
> responsible for intercepting the action of accessing the memory, and enca=
psulates the CXL message and forwards it to the
> slave through Ethernet=EF=BC=8Cultimately achieving remote CXL memory acc=
ess.. Ask the experts how to register the CXL device
> locally based on the control information without occupying the HVA resour=
ces of the master host (OR display the CXL
> device).
>
> Thank you in advance for your attention to this email, and I eagerly look=
 forward to any insights or advice you may be able to
> provide. If there is a more convenient time for us to discuss this matter=
 further, please let me know, and I will be more than
> happy to accommodate your schedule.
>
> Once again, thank you for your impactful contributions to the open-source=
 community, and I greatly appreciate your time and
> consideration.
>
> Regard,
>
> Zhou Tong.
>
> -------------------------------------------------------------------------=
------------------------------------------------
>
>  *  =E5=91=A8=E7=AB=A5=20=20
>    273415826@qq.com=20=20
> *=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
