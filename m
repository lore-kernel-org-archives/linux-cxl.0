Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEE0338F5D
	for <linux-cxl@vger.kernel.org>; Tue, 19 Aug 2025 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604651; cv=none; b=Puthfmm/tgNAlqvM+uxlXMQBPNOTC7iZfckYSvDrSI/zGu4LSXry/kN5fqGoVifK6kmbMVOeYZPvuH5ovo0qTz98+Giv/rvCU/sREdlFzcPzulSULNqqyigXS2I2ICvAS7LZ0bipNEvuIpp7F7gARct4a319KqKoIl1sqftv5uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604651; c=relaxed/simple;
	bh=JoYKdTgaI1IkleXvnC06ZOqDgN1m0OuYsvbAVE+Lvxk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMH22TF8fypVK99jVGApWMefJQqebhB0gZl2BS0fWw4bCMOsGHhqPeomZfihxWBJm/d1FoIFh5mY4p6UPCIalAJU7ZuULmjCy64bjQjz8qWAQWp6SSGC1cjfsUae+zjTfl94k1BasEBIkqEnf5i7ucOy2rgk6Kwu6kp7zKiCxOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5p1M1Ct5z6GFtT;
	Tue, 19 Aug 2025 19:55:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C4B61402F4;
	Tue, 19 Aug 2025 19:57:25 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Aug
 2025 13:57:24 +0200
Date: Tue, 19 Aug 2025 12:57:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 07/18] cxl/port: Split endpoint port probe on device
 type
Message-ID: <20250819125723.0000549f@huawei.com>
In-Reply-To: <20250812212921.9548-8-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
	<20250812212921.9548-8-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Aug 2025 16:29:10 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> The current endpoint port probe assumes the device has CXL.mem
> capabilities. With the addition of cache devices, this is no longer
> gauranteed. With this in mind, split endpoint port probe into separate

guaranteed

> functions for CXL.cache and CXL.mem endpoints. 
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>


