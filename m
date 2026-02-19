Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99427EFE9;
	Thu, 19 Feb 2026 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771499935; cv=none; b=X/qlAs7ZQgdrWsq43DpI9lZhn7ViBS1/lgDneM0NLhYWYiobdB8+P2b8JzmWJfidUvNL4No/dWQTfG2bBCmjodv0/BA6vpUWRbbF7cDYnyIEqrIXReCWBxpH4M+JNIzy2vJeTQc/9ma+voNTcfXxUAggHu+dgZJkKHzA+YsUAE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771499935; c=relaxed/simple;
	bh=YG+hXRU/NbdsSAZaNqaWyalTHSTDvYIGD+YpTLwmy6Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nKbUuMoHoRGAZVqUkY+Jo1asipaFram8bNTPyNvaPWC0lMYsMz47CrEGirXgS8yu4vffmxD0YPAYQUSMTbWrC0D5aKOC7lpiLjige23rbgWuGoLfIO7Hz6otAoRapldLCcgJedcW7QloIjES6WF1EW9qN+ln9XVsZu2vnmLveIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fGrTl6z7jzHnGhW;
	Thu, 19 Feb 2026 19:18:19 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id E45F040565;
	Thu, 19 Feb 2026 19:18:49 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Feb
 2026 11:18:48 +0000
Date: Thu, 19 Feb 2026 11:18:47 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-mm@kvack.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-team@meta.com>, <david@kernel.org>,
	<osalvador@suse.de>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <lorenzo.stoakes@oracle.com>,
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>
Subject: Re: [PATCH] mm: name the anonymous MMOP enum as enum mmop
Message-ID: <20260219111847.0000450a@huawei.com>
In-Reply-To: <20260211215447.2194189-1-gourry@gourry.net>
References: <20260211215447.2194189-1-gourry@gourry.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 11 Feb 2026 16:54:47 -0500
Gregory Price <gourry@gourry.net> wrote:

> Give the MMOP enum (MMOP_OFFLINE, MMOP_ONLINE, etc) a proper type
> name so the compiler can help catch invalid values being assigned to
> variables of this type.
> 
> Leave the existing functions returning int alone to allow for
> value-or-error pattern to remain unchanged without churn.
> 
> mmop_default_online_type is left as int because it uses the -1
> sentinal value to signal it hasn't been initialized yet.
> 
> Keep the uint8_t buffer in offline_and_remove_memory() as-is for
> space efficiency, with an explicit cast when we consume the value.
> 
> Move the enum definition before the CONFIG_MEMORY_HOTPLUG guard so
> it is unconditionally available for struct memory_block in memory.h.
> 
> No functional change.
> 
> Link: https://lore.kernel.org/linux-mm/3424eba7-523b-4351-abd0-3a888a3e5e61@kernel.org/
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Suggested-by: "David Hildenbrand (arm)" <david@kernel.org>
> Signed-off-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks for cleaning this up!

J

