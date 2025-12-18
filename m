Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC832116E0
	for <linux-cxl@vger.kernel.org>; Thu, 18 Dec 2025 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766089103; cv=none; b=uXeQ0RdVjtSdCP2dp/c/wrMHWxPCHLDWMfk41ZFT65kOvgSxWzyUDidU6Fz5GqAg79pUBIR6r3KSlbcE2SGGEXO6sCjlypOZO0zlOvPBPeMOCpdVbbTJccwGr4b5Nt5p+Oby4Se5t3AhgX30BQhGpc04zP+/Glm76CJD64VlwrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766089103; c=relaxed/simple;
	bh=U3vCMMInYTDkNHFporKJMc5V3f7gN6mNypdV65rCfVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJEaxtmvb2pvu02Soin5ZY/1RwRHQQnu9pMynp6M+XnLeOStUpyjmqJWRghTrPbl80zT5Dl4wrn9o6/02C4NwxQj94ZhHikgrcfmCMAUL9GyS54FV+OePpGYL8MgK10DMu9Lsz+0Pynr4TjQvMHvn7PpoikvmxEkv29SREAEhck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ffq+6XIP; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ffq+6XIP"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8b2ea2b9631so97362785a.3
        for <linux-cxl@vger.kernel.org>; Thu, 18 Dec 2025 12:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1766089099; x=1766693899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WSAHGn/yIoOk+6tov/10LcI2FCLjvMFDYZWfNzCQ85E=;
        b=ffq+6XIPuTEFoPPpBNiw6r4eq/ksjOK26Uv1JSXxOuRdiOcHzOAgpxYbRTw/wIH6Eq
         rSdlYPYsdGpQr25ZTDxPOpQ7mOUB2TAWBGIG0Ewv4DIzh8iCjQcMyPUu8PAmU5XkydWo
         UFkhVNt788iIJLO/bUA513gZ6wE9PFVEsqjiPo89r/SKY6dJOJ4F95zgcXcjWQoiA3nR
         fc+51aBXGnBwYg8rWUVKzqmzZUOOCvoCWVEGqF5Mxr3VucOiOFNNWSsOsfCpfhNs8Gsr
         49WG1YeNbhbuLebze3Llsu3wBwIGtKiSDk4Gda4ec29kowS3BrVf8WvvwE5p45oh2SSn
         9x7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766089099; x=1766693899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSAHGn/yIoOk+6tov/10LcI2FCLjvMFDYZWfNzCQ85E=;
        b=vdzx+FKuZmeRtHVvCsOakWfRKr1d9b3V4+NYbb7VA+BAgnslUM41iMTvpOPMZ4W+TF
         Hq0Jy9J9xcIWoeVKw9p2BNvHdUBIgwhGNZGMboyHmeceesONErTElX6iBxRZXKUzzSvG
         kzVH8o3zNGX2D7aR+ArXVEUIFnaRTICDZ2oejOKXtCURlrGZ/Qi3iyJprESCzJO2TMXm
         h7JbRmMvWdMdIqEZy2wi+/WwqAVritTDIbfIn4UnD2+FWTP0wDrt6oGqJbpgnGGpjttn
         0FvFgCmR6OfYD4paT8cMpOs+EZgA0B4d2QC8NrzIet6GzmM+sKEy2eS6/f7f2Z+I0Cyg
         XIEg==
X-Gm-Message-State: AOJu0Ywbbu/9cZNSlhOxbBU4li/B15GuWiED0WpgLq2PgbhHokyitN1Q
	xbDUW6p8IC537x5riD9UG5Lw52Fl2gFcAUMILXX5msPfaMbIU2YCk0KTGVRRN9U0RNI=
X-Gm-Gg: AY/fxX4/PI0QIn8jqtnFKImga95VpmhOXsbrqls7+jm06ef6xtWOWk70Ec9H9ELRD1R
	HHwID2FfOJ3FXFQl4YJ3Rt+zvR9QMzTqs2H9EJtsbKmrmfyLsoHFKWVyDTA1Yp+VUQJ3brCJLOr
	EBHaqvOqM3eqp9x5UgKe8DYWM3MEvKvkpic3iv380VCzeg2TQ2uIXliFGyxTw5eUzNwv7B21d9g
	H/y87uK63YSuRvNhv+IYnKKMe3/vwTaCtJKtVrtIqIFQG4J8p6F69OHZh5typVuJ7XzxANjKGgd
	8ljkd4zUJzwnrBUzMO920HCm4r9KkqmmOPqwg4OUkgF2Pxr3Tcgg4R872V4Zr0zN8X879s77G9V
	wKIzzbqlZpydGEoD1AUfo1DOflmNzW0RDbAJ6Op7QPuFYBSpn61sECRy9/9LTq0Db/+Rc6tXKR7
	nqU1O99erNDUMb2zCb8L4UaUFFoe3MS0PEeJnmiGlxWR/KZUXLm4PIfWK/e64VOM8CtMLId4iFx
	M0WupWl
X-Google-Smtp-Source: AGHT+IG5rhOFiiC0ACso9zoPvELl3akp8DiIdPO/2I7poSmegoCjqVfJHhEZPmrB+VBmLbvlM/aGng==
X-Received: by 2002:a05:620a:470e:b0:8b1:ac18:acce with SMTP id af79cd13be357-8c08fbde56dmr154199185a.28.1766089099432;
        Thu, 18 Dec 2025 12:18:19 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09678393bsm22563585a.6.2025.12.18.12.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 12:18:19 -0800 (PST)
Date: Thu, 18 Dec 2025 15:17:41 -0500
From: Gregory Price <gourry@gourry.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, corbet@lwn.net
Subject: Re: [PATCH v2] Documentation/driver-api/cxl: device hotplug section
Message-ID: <aURhZQalIBu8-KhR@gourry-fedora-PF4VCD3F>
References: <20251218170747.1278327-1-gourry@gourry.net>
 <efc86f10-3255-4132-bae3-8fa6c6dc924b@infradead.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efc86f10-3255-4132-bae3-8fa6c6dc924b@infradead.org>

On Thu, Dec 18, 2025 at 11:36:41AM -0800, Randy Dunlap wrote:
> > +To add or remove a device to/from an existing HDM-applied interleaved region,
> > +that region must be torn down an re-created.
> 
>                                  ^s/an/and/
                                     doh.
> 
> and one note: There are several places where you use one asterisk for emphasis,
> e.g., *statically*. This means <italic> in Sphinx/ReST. If you happen
> to mean/want bold, then use **bold text** (double asterisks).
> 

I did intend italics, but if you think it should be bold instead given
the contents, happy to change it.

> Otherwise it LGTM. Thanks.
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> -- 
> ~Randy
> 
