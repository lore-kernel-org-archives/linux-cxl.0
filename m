Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119BF16438
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666ADE6
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 03:59:42 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8DdD1n02z6K8sy;
	Mon, 16 Oct 2023 18:59:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 16 Oct
 2023 11:59:40 +0100
Date: Mon, 16 Oct 2023 11:59:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v11 21/22] cxl: Export sysfs attributes for memory
 device QoS class
Message-ID: <20231016115939.00001184@Huawei.com>
In-Reply-To: <169713693604.2205276.7697288344292256806.stgit@djiang5-mobl3>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
	<169713693604.2205276.7697288344292256806.stgit@djiang5-mobl3>
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
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 12 Oct 2023 11:55:36 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Export qos_class sysfs attributes for the CXL memory device. The QoS clas
> should show up as /sys/bus/cxl/devices/memX/ram/qos_class for the volatile
> partition and /sys/bus/cxl/devices/memX/pmem/qos_class for the persistent
> partition. The QTG ID is retrieved via _DSM after supplying the
> calculated bandwidth and latency for the entire CXL path from device to
> the CPU. This ID is used to match up to the root decoder QoS class to
> determine which CFMWS the memory range of a hotplugged CXL mem device
> should be assigned under.
> 
> While there may be multiple DSMAS exported by the device CDAT, the driver
> will only expose the first QTG ID per partition in sysfs for now. In the
> future when multiple QTG IDs are necessary, they can be exposed. [1]
> 
> [1]: https://lore.kernel.org/linux-cxl/167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local/T/#md2a47b1ead3e1ba08f50eab29a4af1aed1d215ab
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


