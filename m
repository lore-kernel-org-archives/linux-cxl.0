Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC4E256C6C
	for <linux-cxl@vger.kernel.org>; Thu, 15 May 2025 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328639; cv=none; b=RiBOi8uaIZZXtB+Yb8HoZz3aNPt8A4WCGTgS7NpYLJMonhVbhty2y8pz52Mq2Xtz6N65LClR0x3Pob2nFYkiV3yFzcQS1iWH3kAqbFzK7myBfT3STWNd9e0HCp80M3QMke4GnH9U31JU3Q4H2Xk0eR9YBrC3z1xjZYn9T9KovF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328639; c=relaxed/simple;
	bh=E4GJZBcXsg0vLPkkRU7NhPXqhPVc6tD/e0ROMscpbSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AENcGn0VHA6jKMCj4eoC8lscxKjAQYVWetB7Kj23elmZdbn5zYCgXNzQisAIXSsGBEFaXTOroDbq7o0Ktk6LpwyzAs3/RY4T9O+WgQtp/c7kMv4YUJZ2PH90M39AN5blWwqCiXA638wVYub2y4fOkrwuap5L9d6Qrh63o/bIL9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=vJax4cxY; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="vJax4cxY"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5e39d1db2so68735285a.3
        for <linux-cxl@vger.kernel.org>; Thu, 15 May 2025 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747328636; x=1747933436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wPQRvzzItfeLTE3Yoia8oxTSYi1+CLoQmqrepaqyvc4=;
        b=vJax4cxYH5qNv+mNAE2mE+gEB3IrKfoIUdlzByL2qcre2ZDGIuMosDLPAEwobHMTIv
         hXt3UC2m6rYcktvuG2UzTzsjx4hRrNWVyobFK32FgKyqyF5hJiRTiqumfIqrfUZA7Bhk
         cT8lXLARuVLBbnV+T3WZFOAi1dx6cImouER4Vees3aQ7tLftM2Nd2aSEfoIkJNAKDwpE
         ONM+oSO6kFFKlTczIimWgg5s1VGAuGgLYMsL9VhJtQQDcZRLsNPlfa9gC2QH8gkxxU5n
         TD/PO1RZ61f8WtcoTObXpLWoehJoCyz8PZP3D347NoKfir0Botq4E847NMh0wTZZZ2yv
         WEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747328636; x=1747933436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPQRvzzItfeLTE3Yoia8oxTSYi1+CLoQmqrepaqyvc4=;
        b=Vd2S1JHFsDifghu09kxP+o06tim62Iv5HT0XaLk2UF1mP8boamQi7rSIUv0Ee7L+ao
         jVBPZkUfweD2beBfZ4y7FWkOtq7v/qU7am/lIOCkV8u8oNqfrHxq+64CMGsfOW3uXWEL
         /1mqT8Cbsd39FbbQJg9avGLeid/kc/XVGoFnSpWL69aAUcnPFVTfDb9uXdD0BMJMQ8s4
         6hdJAovKJ42JBa7TTpI2humaQQwrZJQs9I8cjNb82bhMxzLhHzS2ecyt/JfVLTV5t8n3
         pYKEskR2BIsMuS48LGxjxIq8mM4wdnAiykuBszY9RkqXwYKU1h6BYhRvV6gr+liFj1QA
         MszQ==
X-Gm-Message-State: AOJu0YyDr5PBCOFEPW30fgper8opG5LKch9AIhUJJ8W5166TLffIHH2T
	yDEUzynWCUy3bu7PDcL8qZc6fMy5MXhzxC3e0vkyKas135LfVYoDawOJHKTr2JPC4C4=
X-Gm-Gg: ASbGnctrKDqVHhfwTRh9mY+xMpfOrPgoo+SVVpdZizSCmiZnmKAGWz2N/GqgAF+xn5n
	IpFTOiGR6pdaZttWJAfKFPNlIUmIC9vHzrWBIpS/BvoiwP5HMAuyaEFG7Cg9humfwU5B7z2+xh8
	MKpOpklwLM+UNp7sPDKO3JZ0FncZ92EdhxSaSQs6fD+1MYR1ngiEYdHahqgzsRTtoh52yY3i5uF
	q4+VN+rpdwhReSwI9EKjjtTnCjCi9keMmTFCGDAVy13aN/5FusZ7Gxjy6rjdBzDNPqZ/fW7Q1Kh
	2pKRQw4Cs07zgWS0DdlTjXRTCQXhjdIaCvZPK8oJ4fBKePM2uzxa2mE/hquTtQgcmGq1a/ExfAW
	634aw3kKJEIR84W2GC3eYN9P4PWDu3lc=
X-Google-Smtp-Source: AGHT+IGeIFbTWrAS8Vl9zwkgOAqIpet6inwYmXZBgu6TcS74vsKSa4GHXGqwk3JGOJ5gn9q3fTbiOw==
X-Received: by 2002:a05:620a:4114:b0:7c5:e2a0:4e64 with SMTP id af79cd13be357-7cd467adb1amr30983285a.51.1747328635410;
        Thu, 15 May 2025 10:03:55 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd467d7efesm8601885a.30.2025.05.15.10.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 10:03:54 -0700 (PDT)
Date: Thu, 15 May 2025 13:03:52 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com, rrichter@amd.com,
	ming.li@zohomail.com
Subject: Re: [PATCH v2 08/10] cxl: Add helper to detect top of CXL device
 topology
Message-ID: <aCYeeLskYgLD-ExC@gourry-fedora-PF4VCD3F>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-9-dave.jiang@intel.com>
 <aCNqJ5JI2_U7zh-Z@gourry-fedora-PF4VCD3F>
 <96957e88-778e-41d6-a503-1819fac51855@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96957e88-778e-41d6-a503-1819fac51855@intel.com>

On Tue, May 13, 2025 at 09:12:00AM -0700, Dave Jiang wrote:
> 
> 
> On 5/13/25 8:49 AM, Gregory Price wrote:
> > On Tue, May 06, 2025 at 05:43:08PM -0700, Dave Jiang wrote:
> >> Add a helper to replace the open code detection of CXL device hierarchy
> >> root. The helper will be used for delayed hostbridge port creation later
> >> on.
> >>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > 
> > ignorant terminology question: what's the different between the
> > "cxl hierarchy head" and "cxl root"?
> 
> I struggle to find the correct terminology between the head of the PCI (or platform device for cxl_test) hierarchy vs the CXL one we constructed for the 'cxl_port' hierarchy. I'm open to suggestions to use better words to distinguish that. 

Is there an actual difference or they actually the same "device" - just
abstracted differently?

~Gregory
