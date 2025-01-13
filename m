Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF1B1953BB;
	Mon, 13 Jan 2025 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736792410; cv=none; b=sW4A3aIiR3hD6xVMk6V/yNdCBRkQZi0SDe8bj/CXOlP18lJIY/FzvkbQeNsRLuK6Zwp6sp2E9rrGL+xFdacbcJ6usGEAYIF/DKZayAQh9F3EgHGPDo3uhjCIOauUBMrLgKoXdjIgfYuHTRDnkl1f30aBergj9ttRuJkKrkZoJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736792410; c=relaxed/simple;
	bh=pTuHQXIPchKQKR5u1F1GdqpCqct1HLI3JCERDHn1KiQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DB5GOzYUZ5JQtzrJZWzh7J1ZOBgv7Z042/cddkMBkN3UsUh0Q0QNIoCKxUyjlMN0NAmxeZi1YPLtdp0dCY7rhDp3Sp/GGQPGFP3DIflUe6NWlBfkdvWWEKSmOegi5SS0vSg78Tenw1PZmTvRvTw4ZP+RZRl0ufMI2z9FbeWbxTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YX0rK6BNXz6L5Hd;
	Tue, 14 Jan 2025 02:18:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 595F614039F;
	Tue, 14 Jan 2025 02:20:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 13 Jan
 2025 19:20:05 +0100
Date: Mon, 13 Jan 2025 18:20:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v1 14/29] cxl: Introduce parent_port_of() helper
Message-ID: <20250113182004.000023a8@huawei.com>
In-Reply-To: <Z313XWZm2IrAIdcM@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
	<20250107141015.3367194-15-rrichter@amd.com>
	<Z313XWZm2IrAIdcM@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 7 Jan 2025 13:50:05 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Tue, Jan 07, 2025 at 03:10:00PM +0100, Robert Richter wrote:
> > Often a parent port must be determined. Introduce the parent_port_of()
> > helper function for this.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>  
> 
> This is a welcome cleanup for readability, wonder if it should be pulled
> ahead to reduce the size of this changeset.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>

Agreed. 

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
