Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9E5388873
	for <linux-cxl@vger.kernel.org>; Fri, 19 Jun 2026 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781875230; cv=none; b=OJRJWLJe8sARBs4EpljxQEkevywCN1RfFsEu0PjcOAd2kEJUJvSCmHiAWmJnmRjMK3MWaQT7L1DAZoI8cf9+aJ54hOj9Pat+JLQPIPwJzeg+rv6QX+RWIVGxWHPddVVR9qWEAMHUFGwsy/RxcJjKUHA/2vM791kwRVpjdrq7/sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781875230; c=relaxed/simple;
	bh=ik6f+xiyVZf8p/ePmVvntAqGeuAewyuoZ9dkfDvrgnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZdCTqIaOG066yNnqInod4B9aWN6wWCuQOfPMVfx2qerFPnAEpIJuq4gqtfVIyNcNCL/hK5WNxMCyouEPIDGuB8XQRciw9rDG83N5viDMugTGg0nRXjITiq8ONnRpKHPHrH/SEF5p6Uov/+Ugi2AdV+hxylIKLyIlF/9cwu3zHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHkIwS/w; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHkIwS/w"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso14357385e9.2
        for <linux-cxl@vger.kernel.org>; Fri, 19 Jun 2026 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781875228; x=1782480028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jTtn7ASYwiZX3Iefg8PvDQB0Dcy98LO2xsckefXfQo=;
        b=GHkIwS/wA7HB/axNPfimqmiOGF0o4dWPPiUJzm7aTieZB8Vzzp9ku9/IFsKLy0YexQ
         TOcDVIYbsvgv7lXzMRiQtpltJXGFjtHJ+7DR0W3ywZkD1Z654BCZmRTEpYXsEjMpU5nY
         zDZ4RVusc7T2KtJ6fVmX8gPDP4qcjW4hYtTptsePbmR6YqZ7724b8fdokpYPGE0IJwBv
         nLrYcDOmU2Q0NCY4gxYhVPBOi/SgPPXPHGmhsrOfKlfzs4T6aAVNAKf6VKeR6v3zkt7I
         oXPkQOZWqp79MbxANmCHqX/jsnTqU1xr40xGUekF9ApxHGyOve3ytdRzOB/U/f4cCmlE
         2ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781875228; x=1782480028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jTtn7ASYwiZX3Iefg8PvDQB0Dcy98LO2xsckefXfQo=;
        b=loRQ718ikcGY3QGPhC2QBQjZiDDouI03CPjaI6HwOc9sStt1yUhQAybqS7pV7PMj1T
         wgZ4HjoqrOYKEeOl+7oUHZJMuJpucGjMGHvBkCXQDwmNAMoFp0eD6zeHLlhPGkAhW5kI
         Fezvy6vwBTXlXuthKql2I0+anuT8zwIKAi1O1vMKOfmphtpIcKBMFRQnVGyv3O7meyzu
         kNhD36EwAVp9MeteDWPFSeQBRZ1HyUbDsYWBjeXrhNTxevFpnaBB4pOLd04ciFNfMNMo
         xZhnxCjIO2xjvdjbFFRCZ69v0nwGNg8BmpQVE/5spR+UeR2TdVs3mAnpdck7n50S5fWv
         sr3A==
X-Forwarded-Encrypted: i=1; AFNElJ+Qg24eQy6AAkQElU332XDwiL1MSJ4Ibe/DdslyP5qJfmH5ldjxvE4Yxr2ndCkA+GBoSYHj+VKaUKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1mAWft8U+S84GO4v9FgHUBrj8eyNS6XUYk8q16X13IeLmEMy7
	0PQlbZPGCVWn2GvznYhC4q3m23eFJ2FA3N7eHcYuH3sZVypTxoK+uhf0
X-Gm-Gg: AfdE7ckfryV8g96CWhWDsicTdSDgCYHMQ0VkwSjc5KB3SO+ZMFLQphhZ76WVBr6NOVM
	qjSCI9dspg7ukdV0u5P9uj1bg7uyMWg78C5o4fhJGB6TrvmjRAEYhKrDYIXB+e/pHAvI/PBmWLt
	Zhzo2N1us+LTocoh1ACf48kurCS/XyvVIwTqb+dnyc4gxN9R6iTvn2JA6kgoscQWPHsrBHJsteY
	GGOvbqGjkKuTMspZW0pTTzW655M+jIwoacRb0Q2TXJV8FBpCUdX+B5Cf3znQz9qEui1NFpF62TP
	M80qFrvntv5V7uYrGa6XIRYkWWAeLj1N1SLUeoTDj1hrMZJ0m6NE1uIm4jovNNjSNpp4ZI/SUvG
	rKE81lCgnhT90av9N88kgshMd3zk2lSMJbkzWEk8QByNx2TW3RtKXOH0m+wQQ67rx2oooetted2
	M8uE5UIqs0FFYIe5wVn7LThb5OQg2Zf73jf4/2QE59H/sUGqfQg/kEPDc/bTsJs3hzdwJnicm7g
	QTPD2YR95XQzQ==
X-Received: by 2002:a7b:c456:0:b0:491:8043:5c4a with SMTP id 5b1f17b1804b1-49240e95431mr44754845e9.31.1781875227880;
        Fri, 19 Jun 2026 06:20:27 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1ac18sm101853255e9.12.2026.06.19.06.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 06:20:27 -0700 (PDT)
Message-ID: <175fccd9-5353-4675-aa2d-09a98433c37e@gmail.com>
Date: Fri, 19 Jun 2026 14:20:26 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v28 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, djbw@kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260618181806.118745-1-alejandro.lucero-palau@amd.com>
 <20260618181806.118745-5-alejandro.lucero-palau@amd.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260618181806.118745-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/2026 19:18, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use core API for safely obtain the CXL range linked to an HDM committed
> by the BIOS. Map such a range for being used as the ctpio buffer.
> 
> A potential user space action through sysfs unbinding or core cxl
> modules remove will trigger sfc driver device detachment, with that case
> not racing with this mapping as this is done during driver probe and
> therefore protected with device lock against those user space actions.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>
