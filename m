Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9268519047F
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913904; cv=none; b=bmDC1HWlUbLlZmUV6+1amGn4JelN2ZnEgPp5A00usqb07XCn1vPAvhT8kdq8KP6GZ939Sfc3epbmFuCayr4La0YN5uOuvAB+mFlN8wx2IWcRJ2cXCLJ2d22Et91vaD1BpFHdCYAEZ1DpBTMk7Bt+/AA/qJllEhhJSX3qmj3r/HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913904; c=relaxed/simple;
	bh=L1anfXoN05PCUGOY7AZWom7GQqaSaM/fDw2+QkF6Vo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3XZu3KHlEiTCBZv0mYJ68D33As2NgZw+Zgmd/1V1jfUDl/RiyRfdB5hmSvmPDULJAwWaxpM9Kbh+h4LOSwnaRYPclYYpruMYdaK/LonXjgsm1/fzocsa1QtrbxxGUfOOepD03JDDOV+BwFB7xDuXP7XXwyykqf6TYDZNmpDMwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BkQHeCDp; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BkQHeCDp"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6edb82f85so260993485a.3
        for <linux-cxl@vger.kernel.org>; Thu, 06 Feb 2025 23:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738913901; x=1739518701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fe5nMUJySISTMDdWYsFBNWyKneA0oKNO50BAWaJvYHo=;
        b=BkQHeCDpfngmB5FlUpJOemtokwmbASCdz0/qvVgL4zCru4JXxTcVqE+dXZO1gltZg7
         wg66dROR7hbV17QG0Cw0Z3R8W2RSPgnUDsqZ5ulOWwJdrCX5Ss7w2W6FEqsBtapvN0np
         U/a6W9csWIj6GUKZlEdbUZVxi+k6oeHWJ7H0E0+AROZ+36iNzYpEkGer/qVk90Pp7uk6
         WUHp5GuvZkmN6GX12ve5Z+YWrUOr5zXKYV1Av/VRxH0gsAGrSFlNFxk6NrvafxSyx5ZY
         gYVdOQpePUOisUxF+Y+t53gcb4xXSGm2h8T6gQvWJ7bTn3vjQk3qkoCZ3ApCfRooe6L2
         ZUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738913901; x=1739518701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fe5nMUJySISTMDdWYsFBNWyKneA0oKNO50BAWaJvYHo=;
        b=qgKmeIzS9EJNO1rU1pH6GBPceuoF8/N31XmqlJ76S/JfA8WIaOyUPl5bDKbLg3D7te
         Ru8fL31gaiWDX5aJhM5Eb1QSa+dVOa6ZJAKxABUcPdzcf/L/QNrV33zJveY96H1W2dnQ
         BlNrTR3eZNV4WN3EVNyor0N0z3ty2jktytYPBo9lQPSDOBL559utnMTMkKU/aeV/xvEs
         DaFDu/0rYxC/p73weH6/jZvZk+HLnpS4T+e70/HpkRGGsgwxhuN5/rbwzXCH6lgefEKj
         q7JNtlTOTF9sJaFAYWqcm4alAX/Zn4IDkuSsSLzOs6B2DVkxLaxL8zFg3asFVKvPIr+7
         vWHQ==
X-Gm-Message-State: AOJu0Yy8ntWfbjgYwOLZzQcwZpF1A5uxt5N/1MmwksnLnhlAUKMiRDnk
	d22YG3o05fY46+MPR6j3SGMEmSor0k8AEdbk9mon4ay5d0K6PZSxug+6BYneAuM=
X-Gm-Gg: ASbGnctz9zIJY0RBn/eW4CoXcSGQAMD4ig/QZT3YeOFj/xZDt5MfWbjkb9QPXShbWOg
	UgrO9mVmiPtvHk0odjJ+LiQRUNrm1jhY+HlgbTBHWdD9QZHRsYwm+adnJK+DLFw1Dne97nMnmWg
	OuqxHROC+DuGAgCinhCiVaYyLwPHsSyvFpaBl7k3Z3eoBLmSHgHNVqSVXZSf0PKzTr90arCpzVE
	DApqo3b9kOsMTmOEDkGxgl27pZZ1T89NGHmfrfPYsPFMu+F5uu6TMcignKXwL1iQNi+eRkNpS67
	GVm9F8oR3AthpMaZdrhBbbYqbKJ2o9wKQWUI8y9MG4exsHTuuKp4Q+ULD/5MskN3LDcLxJd4TQ=
	=
X-Google-Smtp-Source: AGHT+IEuw8h5SA3eQe8134UELvRpTmNLQAy9StgiwHLMzTdQECTNE9nf7NjgayFhWpOzjVy6V6jtFw==
X-Received: by 2002:a05:620a:2844:b0:7b6:e931:4608 with SMTP id af79cd13be357-7c047ba6ab5mr304347185a.6.1738913901363;
        Thu, 06 Feb 2025 23:38:21 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e9f957sm156492085a.88.2025.02.06.23.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 23:38:20 -0800 (PST)
Date: Fri, 7 Feb 2025 02:38:18 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
	alucerop@amd.com
Subject: Re: [PATCH v5 10/16] cxl/pci: Update RAS handler interfaces to also
 support CXL PCIe Ports
Message-ID: <Z6W4am87XJm6OrBE@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-11-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-11-terry.bowman@amd.com>

On Tue, Jan 07, 2025 at 08:38:46AM -0600, Terry Bowman wrote:
> CXL PCIe Port Protocol Error handling support will be added to the
> CXL drivers in the future. In preparation, rename the existing
> interfaces to support handling all CXL PCIe Port Protocol Errors.
> 
> The driver's RAS support functions currently rely on a 'struct
> cxl_dev_state' type parameter, which is not available for CXL Port
> devices. However, since the same CXL RAS capability structure is
> needed across most CXL components and devices, a common handling
> approach should be adopted.
> 
> To accommodate this, update the __cxl_handle_cor_ras() and
> __cxl_handle_ras() functions to use a `struct device` instead of
> `struct cxl_dev_state`.
> 
> No functional changes are introduced.
> 
> [1] CXL 3.1 Spec, 8.2.4 CXL.cache and CXL.mem Registers
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
