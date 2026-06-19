Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA5124DCF9
	for <linux-cxl@vger.kernel.org>; Fri, 19 Jun 2026 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874925; cv=none; b=NPF9YPbOm63At+xEClF3o/evARtf8KR7nq0TDV6bTu+oy9EKyjeOeMXftfFGajLbNfSrszeUT7+88gKPHHjMgdyqUYBQe9SzxPLIWDxamdfQ46GVqUnGuev50iC61mt70Sn2Bo6sjhPuOV7rZnmoqoVnDsH4dUa1IhWYrrjMAxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874925; c=relaxed/simple;
	bh=ayUz0QK19tunlbuPS6VpdJABgaHjTA/abbzXs3ZADjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+kGbGGTwRS6RCXItFtHRgCAiapdxpOym6ysTq6CGIMt8XYMp/F2zeJYOBHC16zDSAjiZ7h3wJCKQsgnzAEXDydFi+xSrzIM2W41KZkJuNzDvzlr64uBXoXuRw+wIeSvoNYpLF5eEGk65p2AEynvEodG+8DCqh09qwaijIthW7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONrsaVjk; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONrsaVjk"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so3814027a12.2
        for <linux-cxl@vger.kernel.org>; Fri, 19 Jun 2026 06:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781874923; x=1782479723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7g7c5YGTpHzrYKu/toqMo2x8dczkqd8MUSEXNuCeSR8=;
        b=ONrsaVjkwtj2xD7cwcZG+2Kdvm94J2Kh5QKv30DomVHq/vUBmh72z8XFGlbbWKvS/Q
         1J8sT5F5Zx9aNcLtlKVIlC4iL1PqsDB7AbTefreRJHXE8mF1mk+PnjR6ska5/hQLrC81
         ZvrYCcD8kQ45K1SW+31QZRGFr6U2YNZJzUTjcYSNwwd/1IDJgVJ3O7BXvvAvSSdWMkje
         sR2OMsBUMh5u/cZzYjHYAPriBtZvK6jhBKrbtPrNkrZ9FvuBtOdveyB6mu8hYlvyOdo3
         tecGM20Yp1Bp5uvMhJF+Pumui70A5OKwFUMF4KwQLX7wdHqvlg66SdPhsat5wnAacdxx
         KGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874923; x=1782479723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7g7c5YGTpHzrYKu/toqMo2x8dczkqd8MUSEXNuCeSR8=;
        b=FSPd74PgqGLVMRbebevlaowJcykP+bZBpzqBI0OqEwDL4DUK1uSsa51KWHSIWgR6Ta
         09lYAQSu0aF2+lk5LAVcAS9bPCAi+okABxjlug/8+ALjW6MOxBspCO0xqS+V1sQmqC8e
         9y9JlgoWPuIrxA6SvhIysS1mSh5B46UNxd6GK3B9op9yM1hAiXIiqztE6rLDP2ZTrkEq
         ouUlzsqHJRvolVLxHYEDFPnKJvKPdIXnie66OEbpbNFUD9bBQqAkZedflUP5osuXaLal
         vjwtqCT3ZJQlu2xUXwp4TmQpl/JnnOZbcR49jRr5DVf0P2WGjm6xDz+56QWiIYARPxd1
         +2Vw==
X-Forwarded-Encrypted: i=1; AFNElJ/jjm+sB1oT1fgeKgCQS/C6bj4HqgWU9ML7qu9YIsT0JB9XHT3/USnVyySU6uTh4UjwqvXP74Z2To4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3w8e+bmSj9y8Cr+rjlBrz6vOacC9aSrkRCct0BqeTDG2gCVdr
	jgdoNF4Kbp0xcH3V9UDMpNgWSrcAcQqZgZ4VnnUidUmcHADVAAQGJWJM
X-Gm-Gg: AfdE7cnNPqJDSFob4zuEO8ErtwnI4joQD4ofUkhtvrCY/OCWY5JxF+toRCEBoSFCck6
	vz68ricJegWtq/M2DQ7y2vHZG5AdCzYD4XrH9w0g4gEJKzoC2qFkX99m3ifPQ6lnpotO9Vnr+7t
	byU7fZ6ys/L/G56cTbvfvhU+vX6E0WSNadKtwkSQUgQ62dULpPzP7/5Gdy5mLfHDMZqje/f2Qtq
	iADmP3ACdChblxceRTQ1l5D4QKIfDWQGEML8SmrjGdMabNk6r3mLJyBCTYrAyBXzpzTC12/qyyZ
	C3eOGQWIUi6NAxgw65Colbc4Ud4c4Ro70OQNXbs8NrCJIO7wYqG9nGex7v9lOLAy4jm8gMNsC7D
	0NiAjodux1cIr7LxOzoSyhMGhVIxYpcDwq9P7V3jVNwMwu7q4eDO0EOz8gqdo6vlUru9t0zXTaP
	5BiPBh2ZC9SH/2LzNCTl/xDuQVdXkXeVj7QsyVqaoWEy8fi3vs+GYXIZU6g28m/yLW44kYtAgSK
	aE=
X-Received: by 2002:a17:907:3e1b:b0:c07:e025:1549 with SMTP id a640c23a62f3a-c097b395fdfmr179418066b.15.1781874922395;
        Fri, 19 Jun 2026 06:15:22 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0a9a009bfcsm86344066b.40.2026.06.19.06.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 06:15:21 -0700 (PDT)
Message-ID: <421d759b-c7cc-4503-afcf-da998950efef@gmail.com>
Date: Fri, 19 Jun 2026 14:15:20 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v28 3/5] cxl/sfc: Initialize dpa without a mailbox
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, djbw@kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260618181806.118745-1-alejandro.lucero-palau@amd.com>
 <20260618181806.118745-4-alejandro.lucero-palau@amd.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260618181806.118745-4-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/2026 19:18, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
> memdev state params which end up being used for DPA initialization.
> 
> Allow a Type2 driver to initialize DPA simply by giving the size of its
> volatile hardware partition.
> 
> Move related functions to memdev.
> 
> Add sfc driver as the client.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com> # for sfc
