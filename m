Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C0620ADDA
	for <linux-cxl@vger.kernel.org>; Fri, 10 Jan 2025 22:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549320; cv=none; b=T3ZT14gMwzHAVnLjAQ2P3GvYRNWHpLti75vokV+bUx0X+K7wnaRrm8HrQlHJBFk8t0r4YZEzfWU/W8H39NRBRE8PcMu7jAohksnvTFV/GDXVgZ9vcOvm+MzgqERg2jSNeCrs3oRpEAGZAUwJY+KYMB6D/LwCXE14NvNNlGvneTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549320; c=relaxed/simple;
	bh=tkB0rFjPfcHpbWATNzDdg3kElu7IjVuHK0SSAV+NuIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldpX02oZMyOro5xRhjTRiQ1KbRGGuOP6ou5gvT1HuOKe7+Fte0Y/oDq5j9Cx4eTys7MZpW4jpgRN42KDagp+1bzPcq9bTvV+bBYbFU0Vwjzlr7oH3AGx6Ef5GfN7W5jBdvTKR52i/wlGfg8wgqx0ugLVM5AELGf4FLa0hTsELco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=O9CD+RFd; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="O9CD+RFd"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6f19a6c04so220789085a.0
        for <linux-cxl@vger.kernel.org>; Fri, 10 Jan 2025 14:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736549318; x=1737154118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0dBZXtHVzhR1fGQZI0ah+BrsIk9E/sNlK1+0WwUKNWs=;
        b=O9CD+RFdHvS5gdOaKfmUcMC0MaG2whc9IKzYBwaAOBC6Xcg+4Ei7hBndfKPhJa7K1g
         /CNHyojbyd2PInBPCOgyJugFpEmwmmyfgf0v/hGNZitrU27BXPA/dI6lA3FOVnHKINzY
         1Xha578IJ24++s2iyJuRXqdUqb5Kd69M3DnfAQGEX0C6xWBTcUsHjqe0mbV6+SlgOZcT
         svQpm/qo8DUqDL+V4Mo4V5a+rq11v/tgxlwOOxwETZr44ohByFPj4h5HAgOtgbeYPaeG
         k0SSIYfutcAFSmgqCEBChYbY1U3ljy69jhmpbdDRu4qbLre55P07WUfxa4X4McQmUiJ4
         0Fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736549318; x=1737154118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dBZXtHVzhR1fGQZI0ah+BrsIk9E/sNlK1+0WwUKNWs=;
        b=Mce8PsAyldE6dBBTBsyl5vbQMuuxGSyVKHsKR5KRYoxIwMEi5Zo/TwFU2RRVIHiY3Z
         /jW5vltvCvhkCwSwuuEBeU0m9sTeEAkwGRkTnNshsU2JORE8H9JM+RgkHmViv/7zGeQh
         0z8UoU7Z//SsI7qE/I4/PWqCkR4f6x2sNUGDDzO8BqJz6LAscG6kCYiIdJSUsVo+07Y8
         6337oAZxFbf1MrB4/MNwQsFc27cHTOUoXRR4ol2x15klW1fOxKI7Z2hp0SoFUNw/1GHX
         ziG+loQuhTWsJs//mheOn9mCv7r/ypRDvyweI0KOhCSvcYyYpKQs87QIwVuKZTH8e+Zy
         ECog==
X-Forwarded-Encrypted: i=1; AJvYcCXvbPW6q1Pouuj/541smjDUbGgHDpZNk/noko7tJd8LY45yJvtdll1z/LxFNncQAERwWNFopBwFcVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAsej9Hy9QG2Vt8qkmOlC0Ez9LVEtlqRVz2qwj0QtPsJ3x3fEn
	MsmA6JtoJfPrGUH8Ml0pikiPaWg+6cH8kZQE1QZYWKk/6YLti/3Dh4t4QwQsVIM=
X-Gm-Gg: ASbGncvXYIhiWSz2bGDMSAVqn2Ok905TFgZZRVuOcEglOBIZM6sHtD8H16EuWYlDEOj
	0gb33X/ExIAcraklIRgLgLIcGAjzRs1R1clWF1CFPDakkW1TjfuQMYRnup4D6oPxaU1Z4ZoQY6+
	qQD9GsYsKtZiBC+p6YmjcaPsatXzSaG8ChD32y6FDtzREqjIvutW2THNprB5P9pZHjPcbDHtw0g
	cToxce+0Rtk3K6EzOAcjBUpGmsYIcts3MpEtVtCMoy2dYOLVEtrMa16b4q99euuZHyxR96duzpU
	vDG2qXHearzcGOJ7z90atfLHrhGNRRrUfuk2Z9c=
X-Google-Smtp-Source: AGHT+IFdmF5uDtjxfu2kZmiXjGugIKcTeGTNZNtyc1uwSfDY/9bdoLLHSX3PoDntn3g2WmqbiNgPSA==
X-Received: by 2002:a05:620a:462c:b0:7b1:161c:ef58 with SMTP id af79cd13be357-7bcd975aa7emr1743284985a.28.1736549317946;
        Fri, 10 Jan 2025 14:48:37 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3237f0bsm222057385a.7.2025.01.10.14.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:48:37 -0800 (PST)
Date: Fri, 10 Jan 2025 17:48:35 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v1 25/29] cxl/amd: Enable Zen5 address translation using
 ACPI PRMT
Message-ID: <Z4Gjw5LGTppFfuAC@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-26-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-26-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:10:11PM +0100, Robert Richter wrote:
> Add AMD platform specific Zen5 support for address translation.
> 
> Zen5 systems may be configured to use 'Normalized addresses'. Then,
> CXL endpoints use their own physical address space and Host Physical
> Addresses (HPAs) need address translation from the endpoint to its CXL
> host bridge. The HPA of a CXL host bridge is equivalent to the System
> Physical Address (SPA).
> 

Just adding the note that I've tested this patch set for HPA==SPA and
found it causes no regressions in my setup.

Still working on testing the normalized address mode due to a few BIOS
quirks I'm running up against.

~Gregory
