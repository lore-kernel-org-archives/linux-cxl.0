Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC99139DBE7;
	Mon, 23 Mar 2026 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268281; cv=none; b=IxsOIh5DayG+kO1zYnBqAfLxmTKO94yGJAHvs9++0hIVpDU/B5dRRShVKwRFUxrRDK5ZqScXyajwTEVIsq7KuyGNlr4M82bS9Q74V1jyVLfO0aeFeWSM0sZ6Q+MMrfDXxK0Av6xI8RI0lj9tr4LmBaiwgVKEMO28ezoV0l4M9kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268281; c=relaxed/simple;
	bh=zZABfV6e88Ar5Zjk6mu9wuKEH66G8RrloPS7ZafFEtA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQv3WI3usnukVkgihYjTVuGxHVUssmDPsIknENVwNwi9D85HqIIH6Ep0rS+pL99CaHCtinG5Wj3d/fbUwCEMBE3K4GlJAF60Wotq73DPgj7wBqicNwIL3Ro7zGymJ1lRYP/8h9J2qvIaU53x/0UraLs0jvwdkx/XArYP3tz1Ogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ffXHd4MZ2zJ46Zf;
	Mon, 23 Mar 2026 20:17:49 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id CD0BE4056E;
	Mon, 23 Mar 2026 20:17:54 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Mar
 2026 12:17:54 +0000
Date: Mon, 23 Mar 2026 12:17:52 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 3/3] cxl/core: use cleanup.h for
 devm_cxl_add_dax_region
Message-ID: <20260323121752.0000302a@huawei.com>
In-Reply-To: <20260322131638.3636725-4-gourry@gourry.net>
References: <20260322131638.3636725-1-gourry@gourry.net>
	<20260322131638.3636725-4-gourry@gourry.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sun, 22 Mar 2026 09:16:38 -0400
Gregory Price <gourry@gourry.net> wrote:

> Cleanup the gotos in the function.  No functional change.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
