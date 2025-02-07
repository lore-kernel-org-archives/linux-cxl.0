Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9EC23C8B5
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738944179; cv=none; b=MOYi7rXG+k0pujGvMSeJA4Wdr6TUKua+4YajlHigcTZqgzw++AS6wOJ8cbcBQHazF/JvbemVONbJiKppNxY79C8oQkH82+qFhCDu8LtlfeQBvxP8cco2tf50eCORs/BDhE06DurD4vU9kT0jxlY88phfAaQX+4G9MOvKF6wkyRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738944179; c=relaxed/simple;
	bh=qTTrwmonuoBn114EjCukQAQjX6dYX2f9YggJdvYqtuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DG/dEBdqB+nUBfZ1c7YhbBo+MGqB5zPK52UmSR7p5OtCpvRW63eQIGPGhkUHmOAmuczweEnkL8ltTR4kVUL4ouShbZDOhqcxk3NfA3mtUlAU746jKar06leL7SiDd8HvEby7/J8YIRBu3TGjYg6YtfpuVggFftLLpzR3acCUa8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NVZLtnYT; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NVZLtnYT"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467918c360aso26731201cf.0
        for <linux-cxl@vger.kernel.org>; Fri, 07 Feb 2025 08:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738944177; x=1739548977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OxwRHe5U4ZPv9/a1cUnE/D3XB6IfxkHhfzV2eY3RtYQ=;
        b=NVZLtnYTNCy/HsHNR4jyUtDWcTlccc1el7eJr6kCz+d/1RkoP5pvQkpYvEvKX0FdYE
         V7B7QWc2rfI8Dnl2R8/O931FJmLWwhD6D/2APi/vQLap1tzbJq5p9Wfr2TMQoOyxBhh8
         9gBVBuj/UdD5NUDVOCTbsUiPBZ8s5FsmlUbp7rtaI6bjvAhSkHA2aJe05jA8mg2WTk4y
         NcqCC7/9MoyorHvCmiNfjBBnrOk/y4uNkA56+tnxs8DSw6BcYBU1yZLl0UHKrXqdGTCS
         bcriPINk4VZuqsW7PYLRdZwj37vnALSnWAtGZVORNDJnlJZScW39C8mXLWag5hkCdeyq
         NPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738944177; x=1739548977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxwRHe5U4ZPv9/a1cUnE/D3XB6IfxkHhfzV2eY3RtYQ=;
        b=QJ9lzVpXNcutV7+0XWtN6R+DgZdWLYaLjQbPy07Zp7VHqeuaR7oNtyYuzCqVTBYmbt
         2ScYoCoodcMHIwn2liujow6L5q+zp3Gf9dHsPESXCIAl1DcjJ5aUjPufTERMRpfVEDUV
         bHEP0y7CozTs5FQ643uR6/aFYLJwLeFYTY7cLtRW6LzqcfXkMtZ4zvjccFrlRakfMPPm
         YbbvvsMAgCwfShP/Crh1zy4kC6HwGrUJRoLFmuRA7Ikm1BzXXRGCokt1wJbc/3sE2n0k
         YAvyX1erKKSYHkIwd66HgZjQIZPMWvYZKm1JOTJt0mU58N9HHeqEFfGaS9t1xjeELpE7
         ELCA==
X-Forwarded-Encrypted: i=1; AJvYcCVPehw4geL4UxegxOJ1Gsc6OgQ/PxkvI8fiqVrTprO3Wz8Rg0OSKU7RqebvUtIMBvvyd2Am2EJ9zug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0UNTzDk9tFjci3ZjCn1J+dl4lkBWSbdsN07s4Li0wC78K2q8s
	R9/YgV1hD0HHHCWcL6um+yq0BWZPrQgmZo94Jg2g00Dw+JzdoA1DCLaBZX9kF8M=
X-Gm-Gg: ASbGnctjS1gYLiZRFBQk0GMXPbHBRCX3yuC3aXl2Ab6ywz38WZaMoWVd9O1N1cVnoZg
	zn8M02GPdc+bwMAg7zvEpGfuAD0U87wIFsG9qOtH2LR47R0jeZEW2UxCB2hGi2NS2ZBMIK/6M36
	BT3s15vRXTMRkXE+TPyvgRbnK87Pm3cbAQ36KBecrM416AEOrM9ctksbiiFe/qx+8ok6WMvIjd5
	zoiXPUPJ6HlBVzxYKzLZaskaPjH6OJjGdqc/lGqD8vwid0/PVZW82dycYnkgjI3Xer6gOaRmqW5
	l35JJmJiBdeoGPhaoA32IP184YsvEPz9GPf7l+xkjmcsqUQysgfUXycVx+M0HfRU78zRN842IQ=
	=
X-Google-Smtp-Source: AGHT+IFgXCB04Lpt0gpJYG7B8kSjZz+kozBjKHRr1ex1n/QVmUZcaq9+qUd7LdBIW8zmfPollMQw5A==
X-Received: by 2002:a05:622a:1181:b0:46d:fd08:7c9f with SMTP id d75a77b69052e-47167aa11eamr47466111cf.22.1738944175429;
        Fri, 07 Feb 2025 08:02:55 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47153bc7375sm18071411cf.56.2025.02.07.08.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 08:02:54 -0800 (PST)
Date: Fri, 7 Feb 2025 11:02:53 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 03/18] cxl/pci: cxl_hdm_decode_init: Move comment
Message-ID: <Z6YurVy_K96jet3U@gourry-fedora-PF4VCD3F>
References: <20250207153753.418849-1-rrichter@amd.com>
 <20250207153753.418849-4-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207153753.418849-4-rrichter@amd.com>

On Fri, Feb 07, 2025 at 04:37:38PM +0100, Robert Richter wrote:
> The comment applies to the check, move it there.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
