Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5592258B6C0
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788893117; cv=none; b=KLL+902hFJPrWhmo2wsqPl7L7NamjisCqdigbksl2ZXxz2xwYncxll57la5dKX50oAjfc/Lv+o07Pa1dCQN5pZb7zWElz6YvmrIqW/W4juX1IWQNYW4xxSmA3GrQYP3UzpvZAn+v1PPaYhe/+kKsOmRY7as5b1hip0gBGc1Bp5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788893117; c=relaxed/simple;
	bh=DWfAQlCqP5OCC3RzcDl4XtRqRrK9N+g5QmJemJw+NNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwzmtB2S0QVmqtntOALCyC3jjPI0T2M5grT/E21LGd2sMXXr7bmOp8ziPxELyVUpSghIYlKVtd0jRDR3KlgMpDIASiHYYxqVAezwYpBODPsP2JSdYWmho4xejchUsKCZnayHFA7M9fKr026UphYeC6XZ4sDWlKYo14hCLfj3C9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBmewvY/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBmewvY/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8C61F00A3A;
	Tue,  8 Sep 2026 18:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788893107;
	bh=BAugeNvELRtwMfkiKflF7W4RRMUZUjlHyDSEAaaB5hw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nBmewvY/FwG7AFymttbzjMWGRvy/g44MVuMPbTA4TUJ8NkAI2kkqZzFRi39gdzh4r
	 TIXvl9pYKwVUX/+wn6X6ElqIIJK6Jvco8FJzPxeqVlG3PZ/onVl13B/0FpPwUto+ap
	 eJEc287cVPknqngmE2U8Jbn2J5bWlYLgi7H9v9/UwFQMsYKjxBVzSNBmfcSdGKX52d
	 Tz8XPV+tLigaq2lXBcZK5gx4nZ+z6ULzcmPYC7D4hdlOooPIcCsc9qWplloiiOSfDv
	 5JYPSeVVyJsqjbx8CF5S4PZv8tdWsmuiyX9+UG1lIbz9TzQ6pgnxRaNdeX/78xpF7B
	 +PvY9k+rDivtQ==
Date: Tue, 8 Sep 2026 19:45:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, alison.schofield@intel.com,
 dave.jiang@intel.com, gourry@gourry.net, icheng@nvidia.com,
 ming.li@zohomail.com, vishal.l.verma@intel.com, dave@stgolabs.net,
 benjamin.cheatham@amd.com, Ira Weiny <iweiny@kernel.org>, Anisa Su
 <anisa.su@samsung.com>, Wonjae Lee <wj28.lee@samsung.com>, Junhee Park
 <jh9934.park@samsung.com>, Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 1/8] cxl/mbox: Flag support for Dynamic
 Capacity Devices (DCD)
Message-ID: <20260908194501.03fc4864@jic23-huawei>
In-Reply-To: <20260908102124.2231730-3-anisa.su@samsung.com>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
	<20260908102124.2231730-3-anisa.su@samsung.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Sep 2026 03:15:05 -0700
Anisa Su <anisa.su887@gmail.com> wrote:

> From: Ira Weiny <iweiny@kernel.org>
> 
> Per the CXL 4.0 specification software must check the Command Effects
> Log (CEL) for dynamic capacity command support.
> 
> Detect support for the DCD commands while reading the CEL, including:
> 
> 	Get DC Config
> 	Get DC Extent List
> 	Add DC Response
> 	Release DC
> 
> Leave mds->dcd_supported false. Dynamic capacity is only usable once
> the driver can handle Add and Release Capacity events. Detect and log
> the capability here and let the commit which adds DCD event handling set
> the flag.
> 
> Based on an original patch by Navneet Singh.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
