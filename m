Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0156E546
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E4C99
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 03:52:10 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="135356291"
X-IronPort-AV: E=Sophos;i="6.03,210,1694703600"; 
   d="scan'208";a="135356291"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 19:52:08 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 0D31EC68E2
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 19:52:06 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4EC94CFAB6
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 19:52:05 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id D519440E86
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 19:52:04 +0900 (JST)
Received: from [10.167.215.54] (unknown [10.167.215.54])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 681311A006F;
	Mon,  9 Oct 2023 18:52:04 +0800 (CST)
Message-ID: <59e51baa-cd6f-7045-178f-c327a693f803@fujitsu.com>
Date: Mon, 9 Oct 2023 18:52:04 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [NDCTL PATCH v2] cxl/region: Add -f option for disable-region
To: Dave Jiang <dave.jiang@intel.com>, vishal.l.verma@intel.com
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
 "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>, caoqq@fujitsu.com
References: <169525064907.3085225.2583864429793298106.stgit@djiang5-mobl3>
From: Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <169525064907.3085225.2583864429793298106.stgit@djiang5-mobl3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27924.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27924.006
X-TMASE-Result: 10--6.353300-10.000000
X-TMASE-MatchedRID: AvuQOGDihJqPvrMjLFD6eJTQgFTHgkhZ9mojSc/N3QeqvcIF1TcLYJCl
	VuR6WzhZKaK0jzrN6aA3pwoeDAoHmTjBjEWktJsNSHCU59h5KrHnrllatbeJEFc/CedjlcvkRtU
	L4XifTnsMZfyEbRjU2HtBxdKLkQVY5VojSP95QA92jSf4k8Vwmn0tCKdnhB58vqq8s2MNhPAir3
	kOMJmHTD6abDacpRSo0C1sQRfQzEHEQdG7H66TyH4gKq42LRYkB6cWtwQrW6byliFH9Ca6JRSZZ
	KNRwFNWnO4j6S7JFZ9+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/9/21 6:57, Dave Jiang wrote:
> +		if (daxctl_memory_online_no_movable(mem)) {
> +			log_err(&rl, "%s: memory unmovable for %s\n",
> +					devname,
> +					daxctl_dev_get_devname(dev));
> +			return -EPERM;
> +		}
Hi Dave,

It seems wrong to check if memory is unmovable by the return number of 
daxctl_memory_online_no_movable(mem) here. IIRC, the return number of 
daxctl_memory_online_no_movable(mem)/daxctl_memory_op(MEM_GET_ZONE) 
indicates how many memory blocks have the same memory zone. So I think 
you should check mem->zone and MEM_ZONE_NORMAL as 
daxctl_memory_is_movable() did.

Besides, I send a patch to improve the implementation of 
daxctl_memory_online_with_zone().
https://lore.kernel.org/nvdimm/20231009103521.1463-1-yangx.jy@fujitsu.com/T/#u

Best Regards,
Xiao Yang
