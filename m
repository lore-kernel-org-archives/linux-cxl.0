Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C827E205AD4
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738590955; cv=none; b=BoenFyTryCVIKejmePkHrvfNus+Gf92o8W0keadaKFyo5lgpyfRD2K/hhmf+EtNZEkcBEaFe8gOaMiL5ACpAgGM1UmJ8Vef06Y+pQ8vdum5kTSfWGJzY39g0tLcerEVq9Qh2FgH13bXBdpawzfT/7rvyUw//kSm5sBoFXmdBb5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738590955; c=relaxed/simple;
	bh=0NokjUhDaG7J6/le8LDAKvd4bceB4yyqj4EU2rszV3k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROIO2rTrXg7FLMfafGCRvfAjjASIq1D9HNeT9l1NxI21vUk4XOVAnlBV4vyOVWKs9bKMdzbGJAHRXHsjITjP8PZrKUOee5vtr7wz5YmC2kmyEkj2MjYGoyr+iI7xg8C/LRAGPwbGdkTde+gNTTGldGpFUFk3YI1e2glF8smP90M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ymp0M31LSz6K9FV;
	Mon,  3 Feb 2025 21:54:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C61F14011B;
	Mon,  3 Feb 2025 21:55:49 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Feb
 2025 14:55:48 +0100
Date: Mon, 3 Feb 2025 13:55:47 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <alison.schofield@intel.com>
Subject: Re: [NDCTL PATCH resend v2 3/3] cxl/test: Add test for cxl features
 device
Message-ID: <20250203135547.00007ee4@huawei.com>
In-Reply-To: <20250201004815.474741-4-dave.jiang@intel.com>
References: <20250201004815.474741-1-dave.jiang@intel.com>
	<20250201004815.474741-4-dave.jiang@intel.com>
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

On Fri, 31 Jan 2025 17:47:31 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add a unit test to verify the features ioctl commands. Test support added
> for locating a features device, retrieve and verify the supported features
> commands, retrieve specific feature command data, retrieve test feature
> data, and write and verify test feature data.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Seems good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

