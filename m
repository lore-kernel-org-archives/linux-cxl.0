Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADCD3EFD14
	for <linux-cxl@vger.kernel.org>; Tue, 17 Mar 2026 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765969; cv=none; b=BeNOJHCSQlxQPAMa0o9TkfXaygYVMZvj33ahvTRiD2W9qATktTO0IZcECJdDK8Ovi5WXCqmVoqu+iw2Us0q3zH5JeGaVcwPJK/52Wx0oSK3x/IVDwjLRFpSGPCR7HKhUq8junHUkTFFZuvhUeEQIYMigRdJxWBijZCwgQmfAaIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765969; c=relaxed/simple;
	bh=5eMb8fYJO+XYhvxs8TZV3GHjkYLAET9zXcnPrlNmcW8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4tIU/fqxgV9q7WLdqF82uiTZkwJYyfhnRNgZwTmbXfccDXa1qHWRzaA5iBXl2phjJehLlp3D9mZbq5yHV9ua7HDUfguqE42KPVxXjSDBappt5HtF3kzbgdS2OiTbuvb3nlhVV4FkKJ8P9AkVbqOJ4FFZ7aylZkcS98RR2ocGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fZyWQ1B85zHnGdj;
	Wed, 18 Mar 2026 00:45:38 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AFA740587;
	Wed, 18 Mar 2026 00:45:58 +0800 (CST)
Received: from localhost (10.122.19.247) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Mar
 2026 16:45:57 +0000
Date: Tue, 17 Mar 2026 16:45:56 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <mst@redhat.com>,
	<peter.maydell@linaro.org>, <dave@stgolabs.net>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 0/3] hw/cxl: Add fixes in maintenance, PPR and event
 records
Message-ID: <20260317164556.0000794d@huawei.com>
In-Reply-To: <20260306101423.986-1-shiju.jose@huawei.com>
References: <20260306101423.986-1-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 6 Mar 2026 10:14:19 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add few fixes in CXL maintenance, PPR and event records generation.
All 3 of these look good to me.

Michael, please pick these up directly (assuming you think
they look good as well1)


Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks,

Jonathan

> 
> 1. In cxl_create_mem_sparing_event_records(), replace strncpy with memcpy
> to solve coverity warning (CID 1645325) to copy the entire component ID
> data, which is 16 bytes data, not a string.
> 
> 2. In cxl_maintenance_insert(),
>  - replace strncpy with memcpy to copy full data because component ID is
>    16 bytes data, not a string.
>  - remove memset which is not required.
> 
> 3. In cxl_perform_ppr(), remove and free the maintenance entry from QLIST
> if match is found and PPR operation is performed.
> 
> 4. Component ID in CXL events is 16 bytes data, not a string, but event
> record generation copy 15 bytes only from the qmp "component-id" field
> using strncpy. Replace strncpy with memcpy and copy the entire component
> ID data.
> 
> Changes:
> v1 -> v2
> 1. Fix for the feedback from Jonathan.
>   - Modified title of patch[1] & patch[3].
>   - Added fixes tags to all 3 patche's header.
> 
> Shiju Jose (3):
>   hw/cxl: Fix handling of component ID to not assume it is a string
>   hw/cxl: Add fixes in Post Package Repair (PPR)
>   hw/cxl/events: Fix handling of component ID in event records
>     generation to not assume it is a string
> 
>  hw/cxl/cxl-mailbox-utils.c |  6 ++++--
>  hw/mem/cxl_type3.c         | 13 ++++---------
>  2 files changed, 8 insertions(+), 11 deletions(-)
> 

