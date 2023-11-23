Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vgam7iII"
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC48D4F
	for <linux-cxl@vger.kernel.org>; Thu, 23 Nov 2023 02:59:31 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cf8c462766so3288945ad.1
        for <linux-cxl@vger.kernel.org>; Thu, 23 Nov 2023 02:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700737171; x=1701341971; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kyRWAWjyNF6FkEQzc+PM0rCdb0GLg2oq8mkk/2TXrwg=;
        b=Vgam7iII5QOKRnc2/6Rda+XhAnZnKAMxev74GSF+T14Y1oW0SUJK/id+0KrmYQeDLL
         4bXyvk9PrpOdXfC1Mjdq9eZu76YhUPSUFYiV0Cas6uI5Y+EtOum2IKzNmuen0Ps1xz4D
         BoHdK+JRRtL/g2MQoPQ3ZlTaEUwre1TicuxnR+CRyK8OVKVfa9mqvMfnOpg7nIiHFPjp
         AB/4yKv0q+5YGcDiCbnsZISJ20QqCbcqoPbpmHskX4Nj1OFI9ErrCzeIyJ+Ls2rBc6h7
         NAyWYDznNvJV702+d90aNM/eaxMmU4o7CWaHc1TCgaTYdN0ISMw/32Za+3SwCBNmxAra
         nNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700737171; x=1701341971;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kyRWAWjyNF6FkEQzc+PM0rCdb0GLg2oq8mkk/2TXrwg=;
        b=lgqMY2aE7EhjqroP7HsY5P2HbQqnEXQR4elhtw1ZuWp0/jhqE3RLq9G++0dnkVTcGK
         wXxMibr+YH/wen8oSL3uRuSBrZJYpqkI+JzAseJ1cSeGjjI/+P7e4dXP4OKe9whnDaq0
         ttxgBiLdpx0QUrOWml7MOjJzmn3FZaZgVl1MA0hmGla73/B7KfWIqufZpMA5vD05y2Rx
         9UfmonBwDjWZG0FURfpASbXdcdvZGIgBoWW4E9OscruSD288Hu7XZQ8BMpD2iu9djJOC
         /16tI9RNw6lgPN/3uDM6StS6qRbaK10DcKxlrb/kRRv4f3i5HzeyCDiMUqhmQsI6tbzJ
         iLXw==
X-Gm-Message-State: AOJu0YzkKQv1L/NKSUA2Og+es7az+QjSt5meSgWThRZYOx9EZ0CBTFTa
	8BrWckzxfMHxzwMJ2qsJcgl5YqbcvOuYFDTqwTYNFi4EtsFs6A==
X-Google-Smtp-Source: AGHT+IGN5KpUQUf7XqxIv7bPqO4JcO6HwXSVQAsb3n9LAC3+iN+kJR1PMjn5ut0TCmfX/i8GeXK1I48Tq67Vn0+exxs=
X-Received: by 2002:a17:90b:4f82:b0:274:4e9b:7a1a with SMTP id
 qe2-20020a17090b4f8200b002744e9b7a1amr5102259pjb.44.1700737170539; Thu, 23
 Nov 2023 02:59:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NISHAD TAKSANDE <nishadtaksande@gmail.com>
Date: Thu, 23 Nov 2023 16:29:19 +0530
Message-ID: <CAOzEdP__7TU4ES=3gVpCfiBMOChU+x_f-PUNYM8=RUGF-11ckA@mail.gmail.com>
Subject: Device Detection
To: linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

We are currently in initial phase of working with CXL technology and
we are facing issues while enumerating our CXL 1.1 device,
The CXL device is connected to AMD EPYC 9004 series motherboard. The
device is not getting detected as a CXL device and it is not viewable
in lspci,
We wanted to know the steps we can perform for enumeration or what
capabilities to include so that it gets detected.

If anyone could suggest what can be done from the CXL driver package
available in the kernel source (we are using kernel v6.7-rc1 &
v6.6.2),
then we can implement it and get useful information through kernel
logs, as to what is stopping the device from getting enumerated as a
CXL 1.1 device.

Please also suggest if there are any CXL specific utilities we can use
for device detection / Enumeration.
Currently we have tried cxl-cli utility from ndctl and also Samsungs
SMDK utility
but we cannot see any cxl device getting detected.

Please suggest if we could provide any information which could be
essential for this investigation.

warm regards
