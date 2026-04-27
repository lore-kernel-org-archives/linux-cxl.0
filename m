Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9C8386C31;
	Mon, 27 Apr 2026 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293526; cv=none; b=V3cuk6Hx01KKMu2CyrDn7G2Zn47U9NItUSLJvz4nN6NK65MN3ODSSSIU8i585iLDbsRaxRBbc3caxZsFxpiZQZZ9YM3lJrH8dSEDW2gchwgu913BfPizwcyz564rYWl03p0pip0cTkusDVUTaD8LlFrIbysycy6nOTp2+MUB4Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293526; c=relaxed/simple;
	bh=WCOiWJ33H12Gt9WXtMejTD0F71tWc2TIJy7Wuf1KJNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYqsZ9ahy5loz8nFx4XEMa2HgrskG+qdFuHRn8DRzXrAhB4OFZk+uU0VaCFMWoqMBRP3cyZKxPUDtfTtRVJXDtz0GekXRfSk40lR8W5yup0CaM2xWeFzlxrd9G11N/Osl14hF5lI8B0h/YuqtuSAFUmArAa0Z/Vl74t7iD25MAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZ3yZrMn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZ3yZrMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023ACC19425;
	Mon, 27 Apr 2026 12:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777293526;
	bh=WCOiWJ33H12Gt9WXtMejTD0F71tWc2TIJy7Wuf1KJNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XZ3yZrMnToibUBPmSg2kmBm8Bwx+xjBrieLlQ4QIj3Hjjrxaob4B88GjoxsHY5UEY
	 M8W8err9/EUhALKBTfGnRq9KdE00Y0Cjp+GSsOONCnj1rSo4D2Py54L33nmH5aRqfK
	 BZ8F72ojyZZXGzdp94ZawHeczLhHGgUUtmhKQrm/GHJIR6NDkF6JmUemSrkV2kM89C
	 eem75ThSG+TYpL5eU62ebSNHaHx+53Wk+TBKK9naXdWISIqwUFRD7B95HGKf+MMiWq
	 7L+CZVeh0BCqaMPMjnursVny/DCAle92ayIrHd0bkb9Tnk4UobkrALNJlvQpbm0aYE
	 Z1T0BIvrzEPtw==
Date: Mon, 27 Apr 2026 13:38:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ira Weiny <ira.weiny@intel.com>
Cc: John Groves <john@jagalactic.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
 <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
 "Vishal Verma" <vishal.l.verma@intel.com>, "Dan Williams"
 <dan.j.williams@intel.com>, John Groves <John@groves.net>, Fan Ni
 <fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>, Shiju Jose
 <shiju.jose@huawei.com>, Robert Richter <rrichter@amd.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dev.srinivasulu@gmail.com" <dev.srinivasulu@gmail.com>,
 "arramesh@micron.com" <arramesh@micron.com>, "ajayjoshi@micron.com"
 <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 1/4] cxl/extent: Promote cxlr_dax->region_extent to
 an xarray
Message-ID: <20260427133833.61b9cbca@jic23-huawei>
In-Reply-To: <69ebe836a8ea_bde13100d@iweiny-mobl.notmuch>
References: <0100019dbcc13648-596853f3-0083-46e0-b654-396eedd657cb-000000@email.amazonses.com>
	<20260423235158.3732476-1-john@jagalactic.com>
	<0100019dbcc1f7da-e3c5b4b3-6505-4dc6-9952-70a4676cbdb6-000000@email.amazonses.com>
	<69ebe836a8ea_bde13100d@iweiny-mobl.notmuch>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> Look at the diagrams in this presentation:
> 
> https://lpc.events/event/18/contributions/1826/attachments/1435/3335/LPC2024_CXL_DCD-v2.pdf
> 
> 'DAX dev 1' covers memory from Extent A and Extent B.  What yall will want
> to do is ensure that the region extents which get surfaced are ordered
> based on the sequence number _when_ _the_ _dax_ _device_ is created.  The
> order they come into the host does not really matter.  Although yea the
> spec has a bunch of rules...  so whatever, follow those.  But it is the
> dax device which groups the extents into a contiguous HPA range and maps

On this bit, HPA?  Why would extents be contiguous in HPA?  Contiguous
in the DAX device mapping sure, but not HPA.

> those ranges through struct dev_dax->ranges.


