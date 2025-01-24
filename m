Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7C74C62E
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737727974; cv=none; b=KKI7IIiA5RLDdHmv1Hhc4aKI54G4EIPdPi6d8FhUgBh38zhImzTgyQGKfcp5xSQ+2ahdkdAPuT7Cf6Q+/4pO/xKmphF3CLmhuEuTq/pqP9MsuED5DdpWnIHE8AuTjFMY/DDEwEUXYgzGxrIpHmv31n/pekXyEvzUJj54vXOR0V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737727974; c=relaxed/simple;
	bh=9IW+FEfeMqQGUHk0y1uTAP3HmUraCH/aXB3CcHUmAL0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8jpWVE7A1AsT9VIZdyWJYbvG0TSFJQesLrUs3cBy7U8SD2JAzpxc4nywPEFtbPdhd0WBQAOEeJv8JtTlP8Bjgp4toq2xfjBt/M9i+evpogVa/adNSRQGJpmmjXTZ6/xad/SE//9Lohffuwl9R34rEzbjlIsXcH0GoArsBeNlc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YffqF6BRPz6M4GF;
	Fri, 24 Jan 2025 22:10:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 833D2140119;
	Fri, 24 Jan 2025 22:12:48 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 24 Jan
 2025 15:12:48 +0100
Date: Fri, 24 Jan 2025 14:12:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>,
	<svetly.todorov@memverge.com>, <nifan.cxl@gmail.com>
Subject: Re: [PATCH RFC v3 3/3] mhsld: implement MHSLD device
Message-ID: <20250124141246.000040b0@huawei.com>
In-Reply-To: <20241018161252.8896-4-gourry@gourry.net>
References: <20241018161252.8896-1-gourry@gourry.net>
	<20241018161252.8896-4-gourry@gourry.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 18 Oct 2024 12:12:52 -0400
Gregory Price <gourry@gourry.net> wrote:

> From: Svetly Todorov <svetly.todorov@memverge.com>
> 
> Using a shared-memory bytemap, validates that DC adds, releases,
> and reclamations happen on extents belonging to the appropriate
> host.
> 
I'll carry this on my staging tree for now gitlab.com/jic23/qemu (latest date branch).
I'll push out a bit later today.
Few rebase related changes were needed. I've not tested it yet.

Also I have dropped the previous prototype device Niagara on basis this
should give people a better platform to work with.

Jonathan
