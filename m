Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78FE132808
	for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386663; cv=none; b=avLBFD4Nf6V+PPDhQ09C3QjrsPslRAEyczdgUzvmwOnVR93Yp249fNCzpXE99XyhVvIX9CxLdfk+FG361qS/n1YHJAp/ZXz8IXhid8GaAaIO9/TgT0eKhHhG5GWTR02ROgveEaj6MPPHV0hFJAoaPjs7nVdhnQBBVkBeppNmeS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386663; c=relaxed/simple;
	bh=DuWWJ5q/AbleZ5i6kCAvP9wsj6eEkLlJumU2cEr8994=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQMv1+F39xKicjkP/1DGYEk5VK/wcHmtCB/ZaB3nciN4fuBZAbxO0xs3hIjaezTzycoIXxwVaggdCazrDDgv3/92ZBolU6yqzYuqI7yBns9yAQdgYYXUqCTSyhJ5Sv2hBMgzd/X7U6u7CnxKP2D54+4QTl6HnglgktbnVJgl3yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V3K8h0W10z67ZCr;
	Tue, 26 Mar 2024 01:06:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 88757140A35;
	Tue, 26 Mar 2024 01:10:52 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 25 Mar
 2024 17:10:52 +0000
Date: Mon, 25 Mar 2024 17:10:51 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v4 1/4] cxl: Change 'struct cxl_memdev_state'
 *_perf_list to single 'struct cxl_dpa_perf'
Message-ID: <20240325171051.000033fb@Huawei.com>
In-Reply-To: <20240205193218.1657243-2-dave.jiang@intel.com>
References: <20240205193218.1657243-1-dave.jiang@intel.com>
	<20240205193218.1657243-2-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 5303d6942b88..20fb3b35e89e 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -395,13 +395,11 @@ enum cxl_devtype {
>  
>  /**
>   * struct cxl_dpa_perf - DPA performance property entry
> - * @list - list entry
>   * @dpa_range - range for DPA address
>   * @coord - QoS performance data (i.e. latency, bandwidth)
>   * @qos_class - QoS Class cookies
>   */
>  struct cxl_dpa_perf {
> -	struct list_head list;
>  	struct range dpa_range;
>  	struct access_coordinate coord;
>  	int qos_class;
> @@ -471,8 +469,8 @@ struct cxl_dev_state {
>   * @security: security driver state info
>   * @fw: firmware upload / activation state
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
> - * @ram_perf_list: performance data entries matched to RAM
> - * @pmem_perf_list: performance data entries matched to PMEM
> + * @ram_perf: performance data entry matched to RAM partition
> + * @pmem_perf: performance data entry matched to PMEM partition

Just noticed in review of DCD but these are in wrong place in docs.
Intentional or accident?

>   *
>   * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
>   * details on capacity parameters.
> @@ -494,8 +492,8 @@ struct cxl_memdev_state {
>  	u64 next_volatile_bytes;
>  	u64 next_persistent_bytes;
>  
> -	struct list_head ram_perf_list;
> -	struct list_head pmem_perf_list;
> +	struct cxl_dpa_perf ram_perf;
> +	struct cxl_dpa_perf pmem_perf;
>  
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
