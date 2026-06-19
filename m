Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F973B7B84;
	Fri, 19 Jun 2026 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781885841; cv=none; b=kPkebuuugqRPgBPaoC163rWAujFm8dJmbeOo7vEP9Khbfktc39Z9wrjF4IL4wqOTCSoYIRywMhjtYa8Bp4i6sun0a0FQ5fTeAhf6I4LQnTsor3vniKaha1n8dlqsi59sJCOLJHwWSxTMTPWFkTAzJdKjVb+cjitlfQOlqiwYDOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781885841; c=relaxed/simple;
	bh=Hez/6THJzlNXGiz/OjgNp3YP/wptBZbyvAYu93ZLYJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKVG3WIGtdnupFfiqnfbK+JkDAofctq980eHO1AeVk9w1F1P9MRmdCVQgpKDkOxqsLhVpAPftpbQQRIJWHsOUHrlZX0WcsFr0T8jYXo7HVifsgUp49d4UHX5SjHJrb2B5BVm5QadXRjdKv7EqhngFRpAB1xCbT3oXXrfM4H9eYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FbFcWs3f; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FbFcWs3f"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EE47740E00C0;
	Fri, 19 Jun 2026 16:17:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CsVRI4SkSUaf; Fri, 19 Jun 2026 16:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1781885822; bh=0NbenZSMXYebM0Gsy498bp9VLyj7xrVg223GYzgur9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FbFcWs3fCT+DOLcODMx5M/yVEJZdNzuoawHCl1GWlb3q3WvRGXUm2KvJlevmVFMZL
	 tL7TxH01Onso0WohYbvzLPMCSl3kTfxO8eTfAuqQWLSUmKOsg59gM/uJ9N+9mzGRx3
	 ksfljx+eViwR7yB+f8OJPGScVVl0B+o0ZvXnRvz9cFoGlPWVEbe7PSIoVZTgBF/xPj
	 BmocnXhL2JHAfEwTYTKeuD9tYymxd4meODFtB5D1PEO9534K4APooZhOp4Vsmhh7ev
	 yp3W5t2X/r8mgSvP4y/3EwCEYoQRRMY9Ct39i7czoHxBsc4EJb9WKVFo+bhdteAgk4
	 Hd0X+oD4Y6sZ5/J6pQ1l9Oabw/FHU0dYcesErG4rN5NsqBfJMX8ufJj8N9h1+Fe/aE
	 u4JU/HO+Z41xW3uIROhBROSJm+RKgPMvJxus0Jg0+hjWUzGd26c5EAYyGhcmqoqcPS
	 FI883ZndyvWyfSx7ng6dWWD+cQbLFTCFcwjEu8zwIX7/i90FBcNkHSjxNNiLCnIuMv
	 KuW5+QNqhlqLngdHCvwu0ovDm2BOs4WctgZ6SG/HZcuhSdILDLj/AOPjYHikvu54Nu
	 lM9/oDOH2UZ1tSifvg2PzGpMItuQLQNHyEK9NaZjs4deQdg7LSMdaeelOMnhflahLp
	 FD6yNSBYpTKHOXq5Q4fVdj/I=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 35D8140E0140;
	Fri, 19 Jun 2026 16:16:33 +0000 (UTC)
Date: Fri, 19 Jun 2026 09:16:30 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Tony Luck <tony.luck@intel.com>, Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <djbw@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-cxl@vger.kernel.org,
	devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
Subject: Re: [PATCH v6 00/10] ACPI: APEI: share GHES CPER helpers and add DT
 FFH provider
Message-ID: <20260619161630.GAajVrXuZ3XWvK83G7@fat_crate.local>
References: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
 <20260618164807.GAajQhR9J_00j4LxaC@fat_crate.local>
 <eccbf574-a145-47af-889b-ca6dd80f98f2@arm.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eccbf574-a145-47af-889b-ca6dd80f98f2@arm.com>

On Fri, Jun 19, 2026 at 04:41:40PM +0100, Ahmed Tiba wrote:
> I will address the issues introduced by this series. Pre-existing
> behaviour is carried forward unchanged.

So you carve out that code, you use it for your use case while *knowing* there
are preexisting bugs. Wonderful.

Sorry, first bug fixes then features.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
