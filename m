Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD91F485925
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989562; cv=none; b=GwLoXoDB1p1KKZRrjt+DSE4WsQ1TRFp4oF8mVQlGWi8KLjXEeF3fiSNy54I4Zbi1znD4CkKSJe3mAehgbVOxkUz73kqaDdjjdRw3GruebxYLUYhvnOOlhx39y+ONFHsGgX3foTXAdeNGjJPb48X2HVTMY4muk548zGg0hs+RkCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989562; c=relaxed/simple;
	bh=BMmxYAgO+DtfvyaOnH0QR4Z70nNsvZ/xDBLHpIXFKNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMbODknR4OIJ/5VEr6vH9YPvXCZchqhFEFvIr1AfAKvxCcIPVACmzTGh/dfG1TNnt1Rs0w7E+9QBH+HMA0x4pfy/7bA4CdkWCO7XFohrKEyjRSMG3Pd8zBNw0GLarBVKJmWpWGBulKy2Qyo8Dch+W3qaGUO8p0efQE0Ut0rabwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJIE8+j5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJIE8+j5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869B91F000FF;
	Wed,  9 Sep 2026 21:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788989541;
	bh=QRmtyzzhKVFLOShlAf450Ja4DhkmVNqQXB5dHRyKmms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jJIE8+j55PPBk9WCfYlEvwZCxvs+PPlKrMRzS+uNPtU6/qteQJ5HMidw4XEia+5kt
	 AEb1HQ2IA92fdIm+e4cfT4AlHkrsdo240Ftry9+919yB4NeyV4Rj/kG96swkgSZEhu
	 ISOn8/GrxA55fRwLBtqhi/5HgwtEUapJXnFeVaf3dMAZx6SyzZOcWw1b0ORRR/526Y
	 cXcSZUGZthxok+ze+0b+j+72CEuoPgIwvPHkBmDXdvYUU1WcX3dn41iInOJMM+JxNg
	 5nRrOOteqsBV4dSd5dR68CKf0+YJi6NeOuLBBz8M5gp46E9qPGJw4+Nm5AKJTXuYBU
	 khwxeKMZvvPJA==
Date: Wed, 9 Sep 2026 22:32:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, alison.schofield@intel.com, icheng@nvidia.com,
 ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v8 05/10] cxl/hdm: Rename decoder coherency flags
Message-ID: <20260909223215.456abd7e@jic23-hlaptop>
In-Reply-To: <20260909170302.1550680-6-dave@stgolabs.net>
References: <20260909170302.1550680-1-dave@stgolabs.net>
	<20260909170302.1550680-6-dave@stgolabs.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 10:02:57 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Align with the ACPI CXL Window restriction naming and convert
> CXL_DECODER_F_TYPE2/F_TYPE3 to F_DEVMEM/F_HOSTONLY. Type2 and
> Type3 coherency models were named prior to Back-Invalidate.
> 
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
