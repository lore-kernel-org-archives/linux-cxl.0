Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350992FF17D;
	Wed, 14 Jan 2026 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411875; cv=none; b=J82Vny8HkWjnCKrfUDvUaPDfURCDJDc209JXg9PKmyehMWvYqeWB0n6a6saG2h/EZXkIZHUgdhCRZxZjM6goQyz5AwazNw9O6G7h21OJWzHalsWLEvww1L5U9lKbjgbDQ54IK6uRBcHDu4p3Ss5jc5zpaPc3LIudusYB5jlbW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411875; c=relaxed/simple;
	bh=+li1qhvOBh3VkJECAritr5uBJVR1jTq94hQeUp7GKqM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zov5fG7vD2jE5v8MjCJdMkKbaz7x1p+yU3PLBbg4vkfLoQ33MzrMQMpKbnMQUoN/5uT4hMgr7+NS95iSgEZpgqI6H/2EnuH0FY+d2PuI/7W/JfoNexsr8AHEnHkcS2absJxZI8ubsHG+1SPsby5gaO1ij0AVA8Ho6ROu1W7kWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drtSB5GNfzHnGcx;
	Thu, 15 Jan 2026 01:30:50 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 0848240539;
	Thu, 15 Jan 2026 01:31:11 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 17:31:10 +0000
Date: Wed, 14 Jan 2026 17:31:08 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Corbet <corbet@lwn.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] cxl, doc: Moving conventions in separate files
Message-ID: <20260114173108.00001eaa@huawei.com>
In-Reply-To: <20260112111707.794526-2-rrichter@amd.com>
References: <20260112111707.794526-1-rrichter@amd.com>
	<20260112111707.794526-2-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 12 Jan 2026 12:16:44 +0100
Robert Richter <rrichter@amd.com> wrote:

> Moving conventions in separate files.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

