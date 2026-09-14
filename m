Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AEB33DED9
	for <linux-cxl@vger.kernel.org>; Mon, 14 Sep 2026 19:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789415721; cv=none; b=qWDZbQZDie3vTd70KNk/dVegAZC95kdb5Z4AufTycYWaJ3hqKFkve1Hj08NaHf3dGjC+MdiHTmocsRlRkCDm9SJOjZ0oYYzKScx8MmTEIiGgAk2b83yH0CnX76/s/kSJfQCD8WXT7iZRm5J0RM0mRBRSXERckzvJOdqSm2YnPOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789415721; c=relaxed/simple;
	bh=jLFhw1wVXtu7SbCwiVN2IDb/qKNpc3j1M/ZL8gGal/s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiQfqru9lcG1kpKh2jsBYzLCyS2iNtuVrA+auw9H2tnuwwylDGV70xOL6Vy7y8joY1YUagoZAEh1AxDvChwit5wjImrJS1JgrrjljSefyEipPKPXUfRAN4pt5l/y5PvS5Vjw2rTUjDfg/WveSVon9mLdS8LE3AFtOsOYZZvKCeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Df2xjG4Y; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Df2xjG4Y"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469b35611so1355941b3a.0
        for <linux-cxl@vger.kernel.org>; Mon, 14 Sep 2026 12:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789415719; x=1790020519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m6Vw4eov+a5qrNfy/iSdA2rw/R0UkTW6yDScMc9IYZE=;
        b=Df2xjG4Yp244MvQR2Wh4wEHGCTG9t2q2bgruNuPUInteXDDygeMquU7XGgRM1b6xpk
         4A/E/nIS+ZJBiyxsLkSgwWZFAKXJPG/PtjyJ/v7HvFdRwlP1w9eEisE+pa21d9k/46aq
         jDOm8jW+bBYlpYiPhIvuYQ4TY1TqCObqvZVCS4EnxyEArXeVuSVNGQ22jKcbOnLGdhiv
         AIhN0NIG+7mnW1yqqmjHQKYGcluh7Db8DMKek0jwBrqmig1OrxZlid3GeWpxaSw4k6Fa
         dGic21mOrllRn35gVBHBfRmYKvsn6Bsv/V58PbJGiOO4fwy4seXK53PKFitlslqoOtlL
         MszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789415719; x=1790020519;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m6Vw4eov+a5qrNfy/iSdA2rw/R0UkTW6yDScMc9IYZE=;
        b=G8yM9RApf780BcEIWPQZiO4Ep9Ctmx2GZMmufYBkPmfYy8f/3VQLwD2MLOwZ6miwDy
         yV4Tc8fpCPzhZQfAB6RQ2Q8sTJgt1IYkyQRK6qsgjpI1k3gsUOqXWSLU1XTGCQELNgkk
         wcIH9uyBHT9fI1ifLgl27mFvFPWfFcuMsn1knlDtFVU/FnT44GNzuVTPXhjxQBi5Wkue
         TKo8vY30zmJoKtDQVYbagcGaIr8MGvBGSGESVQYygec0bvmQcf183RtzJrFnQO+GXGDV
         7giYDrxLJzorGrp1qz4dJA9ok+Ews8zp8T5N7HUYtJ7UFQ0Gr/VkCyqRDDUznYtZhH42
         FtEA==
X-Forwarded-Encrypted: i=1; AKwUvBzeWCUXFwhh4SRnZAYrRZlrZKijPwWG5YgNohujm7qxk8w0SKkSsjwmNKhXbfPCcW/I3E7tQhOyxCA=@vger.kernel.org
X-Gm-Message-State: AFuF++moV3Lb6a6JQnAgGsK5WhEGQJZ5jnOmiJgTzxApyul6yyW6D2to
	N9/knV3vEXSW49vWefxwYsmPEmljsSIK/fbWdujvtOiUN9fOrtI8W+yY
X-Gm-Gg: AYBFou1A359zTJq7t39iMvqiA7+3czVFS1MBlLXVbQskSRLqtM3xJoHEmVg8JG/dCfQ
	54/Yz0iiAI9SwI2iKk+h2K5wYmyYCkh6SNTwr+7zE/aiha52TpCZ73Kh3JG1Ew47M6Ix+ldN4sa
	s1NDWiohwY1Fh4RkdFFZITGZTHCu/K9Mas+biOo4iwJh0bW7PL7dEB3PiIiHWIUIxU6oHO1D/lU
	f3LtJrDUWvWafg3NL5MCD2mnEuuAhD1bE53xfjBpAUZnoMj4bGeV+TO8TpYge5IXQirxV1G7x09
	HV0nPupBbfxJufBQhMqOuO1SiGV2vJ9xlSQRnBNAuHBTrJOjemOVdAh9oAFk0uUqfxUuhCp9k8g
	vt5cZCSK9BCO/WrbpGTthVEH204UINA0FmEELvcNXA5V9hI+4+acfd5qdwE5I1MRXb6IySC0v+q
	2pEusmTLZ+uotkzo32xfhc8+XOejiuB1mVp+ltxDum6F2KmHSg8MB2ndV9NrFLUkcWi1MYMLCQ9
	YQUAgosnyNxNiwZt5YI3eBxkg==
X-Received: by 2002:a05:6a00:1892:b0:856:30dd:91ba with SMTP id d2e1a72fcca58-86f82a5e779mr8211378b3a.2.1789415719521;
        Mon, 14 Sep 2026 12:55:19 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b287c1b25sm5349940b3a.20.2026.09.14.12.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 12:55:19 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 15 Sep 2026 04:56:31 +0900
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	alison.schofield@intel.com, jic23@kernel.org, dave.jiang@intel.com,
	gourry@gourry.net, icheng@nvidia.com, ming.li@zohomail.com,
	vishal.l.verma@intel.com, benjamin.cheatham@amd.com
Subject: Re: [RESEND PATCH v13 8/8] Documentation/cxl: Document DPA partition
 layout and ordering rules
Message-ID: <aqhRbxm33W3p4n8w@cxlqual>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-10-anisa.su@samsung.com>
 <5bd5dbd90d5029f92232d8b8f18318d4@stgolabs.net>
 <aqRmqRh89HEtlWS3@cxlqual>
 <359d6939623ed64ee17e28a9fa939c46@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <359d6939623ed64ee17e28a9fa939c46@stgolabs.net>

On Fri, Sep 11, 2026 at 01:50:43PM -0700, Davidlohr Bueso wrote:
> On 2026-09-11 13:38, Anisa Su wrote:
> > For the maturity map part, I have another commit at the end of the full
> > series
> > that describes how DCD works from extent record --> dax device
> > creation/tearing down, so I could update the maturity map in that
> > commit, when DCD becomes functional.
> 
> So if DCD upstreaming is going to be multi-step, then the maturity map
> should indicate what is there and help users understand and set
> expectations.
> 
I see, I updated maturity map to:

 * [0] Dynamic Capacity Device (DCD) Support

+  * [1] DC partition enumeration / configuration (Get DC Config, CDAT DSMAS, event interrupts)
+  * [0] Extent add / release event handling
+  * [0] DC-backed DAX regions

> Thanks,
> Davidlohr


Thanks,
Anisa
