Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025F5170A39
	for <linux-cxl@vger.kernel.org>; Wed, 28 Aug 2024 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845165; cv=none; b=kklcuAKf+x+YZDJWYcUWwK2s9DXO52hrNbnnyvI/5Ekwp8XpgDdoTmGsZb418ZQoNlPY/KnyApi1zoPkyzT8+GX2OE515hPksxyE6cwB2nOqJPMYeuudWtVd4JZkK/KVyEYSAz+o1gawrjxDoJSadv5kADNiKUveZGm/ERDGXZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845165; c=relaxed/simple;
	bh=IIVvw5laZtrEqaNXEdnpz7cvDojJbpy/1XUUXf8pMHI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCFSOKkppTs77WgMut6ndUr8FEfV87xMQAfFr0H0tUF/r0zh0eToze/e38oHJSdKJwN23LG89qrxMKzpeer20SVqRJgMJRQaJb4ULfW993SD456CKGKHqI2q9avth9MQ5aci9JbNYCYvcFpocWHpcssoAtfTVde4pj6xPUktLGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv2RS1VTBz6J7p0;
	Wed, 28 Aug 2024 19:36:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FB7A14038F;
	Wed, 28 Aug 2024 19:39:20 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 12:39:19 +0100
Date: Wed, 28 Aug 2024 12:39:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH 2/2] hw/cxl/cxl_event: Fix interrupt triggering for
 dynamic capacity events grouped via More flag
Message-ID: <20240828123919.00005b5f@Huawei.com>
In-Reply-To: <20240827164304.88876-3-nifan.cxl@gmail.com>
References: <20240827164304.88876-1-nifan.cxl@gmail.com>
	<20240827164304.88876-3-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 27 Aug 2024 09:40:05 -0700
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> When inserting multiple dynamic capacity event records grouped via More flag,
> we should only trigger interrupt after the last record is inserted into the
> event log. Achieving the goal by letting cxl_event_insert return true only
> for the insertion of the last dynamic capacity event record in the sequence.

I'm not sure this one is accurate.  We might well have a slow
system provisioning capacity one extent at time (and interrupting).

The event buffer might also not be large enough to hold all records so
the device might 'wait' before figuring out the next extent for there
to be somewhere to put the record.

Overall I think we can interrupt on each one and it should 'work'
as should interrupt only once there are lots of them or
every (n).

Interrupt only fires on a 0 to >= 1 transition anyway, not
on repeats after that unless the log has been cleared.
It's up to OS to keep clearing records until it at least
momentarily hits 0 if it wants to get any more interrupts.

Jonathan


> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-events.c         | 8 ++++++++
>  include/hw/cxl/cxl_events.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> index 12dee2e467..90536c0e68 100644
> --- a/hw/cxl/cxl-events.c
> +++ b/hw/cxl/cxl-events.c
> @@ -135,6 +135,14 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
>      QSIMPLEQ_INSERT_TAIL(&log->events, entry, node);
>      cxl_event_set_status(cxlds, log_type, true);
>  
> +    /*
> +     * For dynamic capacity event records grouped via More flag,
> +     * Only raise interrupt after inserting the last record in the log.
> +     */
> +    if (log_type == CXL_EVENT_TYPE_DYNAMIC_CAP) {
> +        CXLEventDynamicCapacity *dCap = (CXLEventDynamicCapacity *)event;
> +        return (dCap->flags & MORE_FLAG) ? false : true;
> +    }
>      /* Count went from 0 to 1 */
>      return cxl_event_count(log) == 1;

If there are multiple this will fail I think as cxl_event_count(log) will go from 0
to X not 1.

>  }
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 38cadaa0f3..b0e5cc89c0 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -170,6 +170,7 @@ typedef struct CXLEventMemoryModule {
>   * CXL r3.1 section Table 8-50: Dynamic Capacity Event Record
>   * All fields little endian.
>   */
> +#define MORE_FLAG BIT_MASK(0)
>  typedef struct CXLEventDynamicCapacity {
>      CXLEventRecordHdr hdr;
>      uint8_t type;

