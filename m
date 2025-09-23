Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D042512EE
	for <linux-cxl@vger.kernel.org>; Tue, 23 Sep 2025 03:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758598014; cv=none; b=WPffD3JZWcgBdLiF9LJmXfjdcMOxZJZksZYjfVRCjBEmXAzwwVTijAxk4+SfiDMDP2JEF/ZPW4wyzTSU4Nvkfxfr4F1ewElKeLSJDccD6SpMFArmWCaKd7r3G62hWrHK2zylEI/k420XIglI7vDlitj3dGNJLOLHMz5kF8R+hyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758598014; c=relaxed/simple;
	bh=Vg9sLPfag+hclYKfgqP/HJ0ojo0K9cjFMBX7rdhllww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5y8fgcyzNsWAU1EujSXs9Hko2FTCuRFNZJhGKHibUr4sPq0vyrk6FsiM8ip6QJnKjaZIh8hRSwWaj7sMyNM8dliLhcFamOmT4RVUbEaGO35c9jYR6hlBbV9hU0v0mt+Dk3v6526l3zYDa/XcUGFnhExMZpKgIvvWOMzgX/X6mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=B1WKYWjY; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="B1WKYWjY"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-4248746aabfso18987655ab.2
        for <linux-cxl@vger.kernel.org>; Mon, 22 Sep 2025 20:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758598010; x=1759202810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vg9sLPfag+hclYKfgqP/HJ0ojo0K9cjFMBX7rdhllww=;
        b=B1WKYWjYmy4gv+vzRyrLfjiU0MkSUOaLCyJd07WRH9KWZ2R/tDXidu21hNxwOzCFD3
         3rQ9VjykxqPt1+I+eOVreO/0x9n8cwVqERWQuj0tFvn//HyDx1Vf4NTTIpFtAMYdThAk
         O2fMDbiE6kjvSX9FUmrLwVXoVbl9LFlKnDeDRrbTGxCzHWparxb3VSWJZPCMVUY66lWD
         nvvgCAadww3QX1ezKbcU2k+U2M1YTLBbUgXgwO8EXYW+Qhol4x4Zuw5CBDiliNw6apXx
         1R3kd3z1LGDS+KLQWhpNMJ95gc28YXOE6i20jRRK8z7e2Sx8HecXvwoXi5HxflXahbCv
         1JKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758598010; x=1759202810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vg9sLPfag+hclYKfgqP/HJ0ojo0K9cjFMBX7rdhllww=;
        b=wJls8nQN7qYnqf/l/BWptcztC/EJnx6UWZcbtf1hl3EOlQ8YUpgaq575oM/fzasfyH
         ewxkZI1zkkY6JrTEugmJ5eButIdLDQhNmeveXe217CZ277IMOcpOd5Ylxvdcpu1dRn3u
         hs6EokXIfwBzJn1BUMxbp6v4stG/niPwOy18D55GIbYEdSy6+17z7SuZmMhM6DXVgPBI
         B5egcGEPGMsbzcPAaLV7cGETNeLR5cA0WN1PVAlmjiudhRMWbEFrKo/SlKhtrpXARAsk
         dHUZdrlCuUve62bnQvOzQWzF21+evbwnKYgU+FvED4xK2V5TWwwtpBKZjeN9/UjfwbLd
         ILnw==
X-Forwarded-Encrypted: i=1; AJvYcCW/Fwo5UWcP6PqWn5aBO7dxpdF4KamGlxNJ9RPbQFfy3omr0esSq2jHE/u2b0lu40g5AeXDXoRZFbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1fLftGwpSM9nqVxyD3QdqcR37M6ijG+Rs+nm6WriogwByYbET
	VNiWGzntSPLEclq4LqZA/1e9099dWSjkxrx3e9PRynoDRP4XEFa929F+a/H3fZ76WI0=
X-Gm-Gg: ASbGncurbi9etpYvnEv3syszJmH5fLhR8ublrOp5A+yMSy0ZKaGAUgj663Ux3ODF7W7
	CEUIOz8bhROnArHg/Jymi4vwbS9Jlkb581bcFX/rIS/X+URHwe6rAtXQEEQgLWQdHJFbBT2oMwN
	ENjao0cWPM+r8PDC+Bbab7jVaMFP0X4wKRtYQzM3PrjPqf8FVrvoobXCl/hJyueUQqSF9Ml5guT
	QbTvtwoveEaO+6CNcFscRvIcUae8JeFMar2POm3RebdGgWM6cE1eo0I5Jrr4AOMPkJcjr8dZCDI
	UWzFJlOemq43RGtt6KDOfNhdumh2hF/mONpTbggwPqaZvaSS6pVYfhYI2LT/sISwofdqp9RtqYJ
	EMAsw+ZoVg5Be7OE7X8wt7d+RB0LPwGfoT+Z0hRGX1IRqdmTwqztJlHZ1Lm9rnw4H0re7mZn5lC
	U=
X-Google-Smtp-Source: AGHT+IEphIF7dofS5m1gnjIZO/Curkkg49/kjN7MyLzNTCf+HdWQIY62aCg1IDcJ2axM5gtNDYiQcg==
X-Received: by 2002:a05:6e02:1a8f:b0:425:6e9c:9443 with SMTP id e9e14a558f8ab-42581d47f08mr17907505ab.0.1758598010480;
        Mon, 22 Sep 2025 20:26:50 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (50-32-2-77.vng01.dlls.pa.frontiernet.net. [50.32.2.77])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3b012b8csm6520513173.16.2025.09.22.20.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 20:26:50 -0700 (PDT)
Date: Mon, 22 Sep 2025 23:26:47 -0400
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
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 00/11] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
Message-ID: <aNITd1fXcBxKM5mF@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-1-rrichter@amd.com>

On Fri, Sep 12, 2025 at 04:45:02PM +0200, Robert Richter wrote:
> This patch set adds support for address translation using ACPI PRM and
> enables this for AMD Zen5 platforms. This is another new appoach in
> response to earlier attempts to implement CXL address translation:
>

For the series:

Tested-by: Gregory Price <gourry@gourry.net>
