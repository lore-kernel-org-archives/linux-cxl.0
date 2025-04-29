Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EE3225A32;
	Tue, 29 Apr 2025 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941093; cv=none; b=rH8YpuvD1B7esy7m1o3L8O8EFIpHOmsOjRjKgU0JQZQcIGvJlB1bGfQ/C5SVSGw4ytajm5McwhDOuNG8us8D7Hc9sPpFdYzGgWDmc8EQT5+E2R0fO0XzE0UlZp24emp0FzIKzvZJeaap94Ko5/yODlO8td6XEWJ3+mA2eM8dzZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941093; c=relaxed/simple;
	bh=HYavvVebq5zJiQqsirFBwl7rFYFkEzFw+qDi5Stqkqc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvKXMoRXAURfhnnNhIMzjNQmFZ2GjlzcokHU1z0+uOQ0UrB06NRBWG3FjYCOcpeT4nxTtgU5S9v3tZQPB0la7NLHiQUtK4O/oK/86RIPZ5jp4HSCY9eogKhxOSQvDyU00uoJOS5p0JIE5VYqP54mJiV6ak5qyj6/TNU0KB4EmsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zn4986Rgzz6M4fS;
	Tue, 29 Apr 2025 23:33:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F5101402F0;
	Tue, 29 Apr 2025 23:38:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Apr
 2025 17:38:07 +0200
Date: Tue, 29 Apr 2025 16:38:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v5 08/14] cxl/port: Replace put_cxl_root() by a cleanup
 helper
Message-ID: <20250429163805.000034ff@huawei.com>
In-Reply-To: <20250428214318.1682212-9-rrichter@amd.com>
References: <20250428214318.1682212-1-rrichter@amd.com>
	<20250428214318.1682212-9-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Apr 2025 23:43:11 +0200
Robert Richter <rrichter@amd.com> wrote:

> Function put_cxl_root() is only used by its cleanup helper. Remove the
> function entirely and only use the helper.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron < Jonathan.Cameron@huawei.com>
