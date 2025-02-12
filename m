Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14514A31
	for <linux-cxl@vger.kernel.org>; Wed, 12 Feb 2025 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319087; cv=none; b=K/ZygL/RQaj1v+xfevl0WdzKdv9xjS8HSDaeOd8qxEY1VNSjJXlQI0mTFycIUSzm3aJFTCctuLJZB9djBO9ovCLoJm+iaqfSig7pZKkTyGYouQ0LHPJ4tTLhgCroW84IaqOvYVutgjW+NSdk5/nxLdqAYNpkI7fYHZtzBemwe08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319087; c=relaxed/simple;
	bh=qfqWUaxj4M5XI8X8hWIn0j03pFGWYZcGVqGDzFiPUfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWH8d9SGHoc+IpVQDfoaqmfBeLGPgEeOxKCYr5iAPCjWJvtHqdnZQ/LkR8ziHEZOUaONOshgDOOdF6up+iYc438iPk5sdLpd5sxrMWL+IRfRrWjY1XpYGgQufy1VNgxmvVhDebGp8JFRaOKR8FIluEjz7WhP/62+t2nl46+23B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QraXSjfA; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QraXSjfA"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c0506ec9b3so392591485a.1
        for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 16:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739319085; x=1739923885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aMkf5oPLsMJQj2JhE5y7/ZrwjQP1VsYL3M5+AWgX0gA=;
        b=QraXSjfAWVOjH1StPU4l8HRAErmPT+Gm0pdnhEDejP9/qaj8snwSnYirygR2Zgiof3
         +jARFhrlEBN5bR4WCflWGI61CUt545DDL5vIxPgVSj5h1/VpeAhKBuOjTsMo4cQQbgUb
         6Qh0kShh0thOnGSPZwxs118qXP5MyLad43OA5L9y/6++EyQT1nlJFnROiCxOQmFDm8kb
         M8slzsWrkyHwld+oMJ8kC9ucYNk1jDP/dYtWwfu8jQAWViUHKLvln2snUjRgO8kRT1vU
         n5w41P4hadn7l1NHptslSHIbxU20mHW+R8ICinJqiYuMZtuya4ymNxzElp3da+Hol7tY
         Gp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739319085; x=1739923885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMkf5oPLsMJQj2JhE5y7/ZrwjQP1VsYL3M5+AWgX0gA=;
        b=jXvRTP8zl09rNo8OeIhzGBlI9CXhNSG22pGFaZIGDKX9P1oXnDeWveWvPRqdy2c2MK
         otYvEePos3uBkq+og1ioIrwbzGXRpIojywuJzCr9/0qtPmepHl6g1Hbt5bg19/C0Z1LH
         ktgEZoONTuXbAjVMvAOEieatbtQ8dlCm6L2xqpHaQZVZU9iYG217uiGwKkoXQXbsAJjP
         xCom6u9KHbeP+QCSuACO6zPn5jENjcYgDvm6EUORrQmFReCmI0hzmi9Rh6pk8bjr42RO
         e2TUleuB/WkZXagf64mrfenomQdS59J2y+sg4t9cHXZ3Nv+03sTEfxeTOh8GulhpgAAB
         Baiw==
X-Gm-Message-State: AOJu0YzkpT3nMCAvtHGQtGspdTqaWiKNJVsvajW/UFsD4wdCdNEyBiMa
	Nan1TM8cQquLto/vtOjKAGb0X35ZA0sznlqU7DqDtWGnyzga+rrrYDlOZb6gjgg=
X-Gm-Gg: ASbGncuAW4wNYKqy6G7Z++9LyiAK1o8NY2+8SgE/p+Gilq1+4v7x5MTgFrwnEkGMxS7
	FIbCa4iKAzFXjIhMTGpzU0dNitwquVJQaau2MKgRO0j78BrKd5l+dB1QWhRLsN0T7CD/DxSBKrS
	5w0zzTj5xBIU4f/2y2nLMuT/hJQhd+7KkRxFW0fKqKzjUIhBfi8POaE3SMd2of9Wet2IqKm+GJT
	I8Jcb6H7pC19tJQU5oW9vTuURc9Y5CCBzkCwc2sdx0RdDLfZodyCmqLzEM8aq8bbecICZSZVi+v
	cdeZAuKiPgleWJpLW3FxBns0NQAxqG92MOKdi2XHRLKcsR27tyIOWhgJ4A6jS4xQ4XIC96Hd2A=
	=
X-Google-Smtp-Source: AGHT+IEhQLIsJaG/fbU8sJBgBx+OFg8MFFCqDuN0KUnDhhirQwBhRT3I4eLnjVSHDoK5Bq2ymF340g==
X-Received: by 2002:a05:620a:6293:b0:7b6:d6e5:ac6e with SMTP id af79cd13be357-7c06fc57302mr210133485a.4.1739319084971;
        Tue, 11 Feb 2025 16:11:24 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c065424c9esm257293885a.43.2025.02.11.16.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:11:24 -0800 (PST)
Date: Tue, 11 Feb 2025 19:11:21 -0500
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
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v7 13/17] cxl/pci: Add trace logging for CXL PCIe Port
 RAS errors
Message-ID: <Z6vnKT1pXuON2WNg@gourry-fedora-PF4VCD3F>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-14-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-14-terry.bowman@amd.com>

On Tue, Feb 11, 2025 at 01:24:40PM -0600, Terry Bowman wrote:
> The CXL drivers use kernel trace functions for logging Endpoint and
> Restricted CXL host (RCH) Downstream Port RAS errors. Similar functionality
> is required for CXL Root Ports, CXL Downstream Switch Ports, and CXL
> Upstream Switch Ports.
> 
> Introduce trace logging functions for both RAS correctable and
> uncorrectable errors specific to CXL PCIe Ports. Additionally, update
> the CXL Port Protocol Error handlers to invoke these new trace functions.
> 
> Examples of the output from these changes is below.
> 
> Correctable error:
> cxl_port_aer_correctable_error: device=port1 parent=root0 status='Received Error From Physical Layer'
> 
> Uncorrectable error:
> cxl_port_aer_uncorrectable_error: device=port1 parent=root0 status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte Enable Parity Erro'
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
