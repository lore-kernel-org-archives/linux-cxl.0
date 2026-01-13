Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F154299949
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768311237; cv=none; b=fSAQnnZuZ1eVFCCZj7L9J8ENEW/byzF6ZSJJDdjIe4/9faHrcRTaIBk4/P0/bkfLjRlyQqICA7iDluy28f9bCaDlyhk2rySNoQj1pZWeogZIt2korzSna7PsK7raoVHpcd0s4dzdq7a6aQDr7i4uWHkzWGgjn+h0usO7TTtAkis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768311237; c=relaxed/simple;
	bh=nJn/IgS2fQ4v0logMt+CBQKLENdUOAdE0tT1/1E7ec4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/vGI7ZltfwhKjUjbTp34ShusgG/bqTE8hSC1MFOyELTKIuhJtfVyo0iAhlv8WCUu2TVbOKcB8qW5bOpmNDkCHOw1fjxPjo/UarTL6LNyld55JgxW2/Uzhi84zHc885UsOPcwIyrRyLUtoXa3Q4Ckf6P7lzIbtsNXHCL0MQh6/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Fjm5kLVE; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Fjm5kLVE"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b29ff9d18cso804230285a.3
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 05:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768311235; x=1768916035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e+TrcPiNJqx+gnXGDZ6bofmiej5uYIiBxFLYJ07vJ3g=;
        b=Fjm5kLVEoFp9+qyrA+upskKg7lKiuWxhzeaCrMLPFGi3cSB9KGDALfGU7rMGEE1mpa
         OWEnDXSq08/wPdk0B9mMXhae3D38TAWmuoOr+3TxQk7zo6sWQbv6MHLW4vq4IZOocEPZ
         N9JGuEZqxpB90gkPZywLR4K+lER+ipPN92ZpgzwqmTd5khOVb6e4lX1v+qcqL6/w1ugO
         5gCiRKWoPvAITK8d57CrEZ1ZxfJmkI6YQCunVZ6es4hvJvzCzYqiT7xguWe+Hebd2BYq
         NTy9t3Vssnk+q91zzvhygakKA/lg/ndsEy5bQKGYPw288FWG+K9ybNRgapoZnRvOlnGK
         pWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768311235; x=1768916035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+TrcPiNJqx+gnXGDZ6bofmiej5uYIiBxFLYJ07vJ3g=;
        b=RIyvDVqEtsnKtsj6NnkAoQoneqSh8LTqXnzAeAskmX6FQzh0ptDtV9vle4H+G6eqAA
         djt27aUx6KIEwS7Bd//6zcfGQG/gpvlWgiq/QBNR3Eq3lizMwZiozrpqmCOhPx6Hqun8
         m76ujUiDgHX70GmIliEDX4S/tw1V7LKHfsLP/htGOJTLddubv4S7ZjzwlPEV8aKkmgBA
         iWgZgBkDTXwAwur2q8QU1kiA4r2sxZ5Gj38THEJm3JnkALMDelN+ncFvx9eNpxT+rWyD
         +ALrhfS9jvlRmK3WshpvZcoFU7BsORHJeIYuoFoVuCbqegrSJFyeklf8as+wtS1gr8FC
         5jAw==
X-Gm-Message-State: AOJu0Ywj2yYS8VHdr5JBPtsOZVbuYdPDYbSmZTlmxfIrMv+wpAOlODJY
	dxAF1Ve8J/0xDlaM1pcK0jyth4QgSHau4HJBNbmi6Fa0gQW3XgtQf+am0A0knQdbH8U=
X-Gm-Gg: AY/fxX402Z6+ieOzInSQh/Wftxsw+1hvMsyYcQdvyW4Ilng38Fqa2RF71UeBIdse72y
	WfDj93OrydgXehxa8kSqK+kb/xSarhqATfjzgSeWdJW2NC64HDx1h7gSUmS6Es7aa0BJ9Tk4F1n
	v1+Ieer7f+HvLKcv6LoPZ6hQrTXDvpH9XIcJaUo8sHFrD/n4X2HZ4ELUefPe2mF9RSnYmB4t4qt
	H7rQtM7PV8JwUg3t9EHVlh6QBZWM860w7PBam5PdIC0T5PfS2LxCWF3Bk2Dx0weMCdj/ET5Rb8J
	KFkucu7fiNZdsdbb/gm6G6zUjk9Rtj5wx0hplLUGTngFnUmnkVxdlbTv3C3sko0rX6ND5uEvomW
	HeV7ZKbBEfnmjFminI9bk0OFGVqpBlsFtnqc/485dUiDJVkaEl8ubrRSuT/tfKjSPpkKm9VwdSt
	pkvc3QuESza34FxTh9ncKbhy5+ug1NrHtdbNCFW+nM2P4SlnF3s17QYUl5RfRLjCoV4a1S2A==
X-Google-Smtp-Source: AGHT+IG89U0CT8ITbK5rc7fc4hjt8fIdrG81Mm2wdS+7eaGchNv6ND35gsVJ60oW2+UHlaYLTvZRJQ==
X-Received: by 2002:ad4:5cca:0:b0:882:3f45:c811 with SMTP id 6a1803df08f44-890842dc572mr316656616d6.61.1768311234825;
        Tue, 13 Jan 2026 05:33:54 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770cc7b1sm154860746d6.5.2026.01.13.05.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 05:33:54 -0800 (PST)
Date: Tue, 13 Jan 2026 08:33:20 -0500
From: Gregory Price <gourry@gourry.net>
To: Neeraj Kumar <s.neeraj@samsung.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, gost.dev@samsung.com,
	neeraj.kernel@gmail.com, cpgs@samsung.com
Subject: Re: [PATCH 0/6] CXL: Introduce memory controller abstraction and
 sysram controller
Message-ID: <aWZJoBwSLl8ukFZd@gourry-fedora-PF4VCD3F>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <CGME20260113093758epcas5p10cc9749a657b8e4d32db75b8b973b67d@epcas5p1.samsung.com>
 <439928219.101768297204618.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439928219.101768297204618.JavaMail.epsvc@epcpadp1new>

On Tue, Jan 13, 2026 at 03:07:49PM +0530, Neeraj Kumar wrote:
> Hi Gregory,
> 
> I am facing compilation issue with this series using CONFIG_CXL_BUS=m
> {{{
> 	  AR      drivers/built-in.a
> 	  AR      built-in.a
> 	  AR      vmlinux.a
> 	  LD      vmlinux.o
> 	  MODPOST Module.symvers
> 	ERROR: modpost: "device_offline" [drivers/cxl/core/cxl_core.ko] undefined!
> 	ERROR: modpost: "lock_device_hotplug_sysfs" [drivers/cxl/core/cxl_core.ko] undefined!
> 	ERROR: modpost: "unlock_device_hotplug" [drivers/cxl/core/cxl_core.ko] undefined!
> 	ERROR: modpost: "device_online" [drivers/cxl/core/cxl_core.ko] undefined!
> 	ERROR: modpost: "walk_memory_blocks" [drivers/cxl/core/cxl_core.ko] undefined!
> 	make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> 	make[1]: *** [/mnt/ssd1/neeraj/dcd/cxl_env/cxl-linux-mainline/Makefile:2004: modpost] Error 2
> 	make: *** [Makefile:248: __sub-make] Error 2
> }}}
> 
> Above routines are not EXPORT_SYMBOL_GPL(), thats why with
> "CONFIG_CXL_BUS=m" its breaking.
> 
> After adding following EXPORT_SYMBOL_GPL() below their respective
> routines. This issue is fixed.
> {{{
> 	EXPORT_SYMBOL_GPL(unlock_device_hotplug);
> 	EXPORT_SYMBOL_GPL(lock_device_hotplug_sysfs);
> 	EXPORT_SYMBOL_GPL(device_offline);
> 	EXPORT_SYMBOL_GPL(device_online);
> 	EXPORT_SYMBOL_GPL(walk_memory_blocks);
> }}}
> 
> Can you please have a look?
>

Much appreciated, will fixup!

~Gregory

