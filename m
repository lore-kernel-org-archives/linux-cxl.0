Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215F8F4E5
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9049DD
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 05:56:02 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5CRt5VZcz6K7GN;
	Wed, 11 Oct 2023 20:55:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 13:55:59 +0100
Date: Wed, 11 Oct 2023 13:55:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v10 04/22] acpi: Move common tables helper functions to
 common lib
Message-ID: <20231011135558.000051a0@Huawei.com>
In-Reply-To: <169698632139.1991735.18186364194767139441.stgit@djiang5-mobl3>
References: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
	<169698632139.1991735.18186364194767139441.stgit@djiang5-mobl3>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 10 Oct 2023 18:05:21 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Some of the routines in ACPI driver/acpi/tables.c can be shared with
> parsing CDAT. CDAT is a device-provided data structure that is formatted
> similar to a platform provided ACPI table. CDAT is used by CXL and can
> exist on platforms that do not use ACPI. Split out the common routine
> from ACPI to accommodate platforms that do not support ACPI and move that
> to /lib. The common routines can be built outside of ACPI if
> FIRMWARE_TABLES is selected.
> 
> Link: https://lore.kernel.org/linux-cxl/CAJZ5v0jipbtTNnsA0-o5ozOk8ZgWnOg34m34a9pPenTyRLj=6A@mail.gmail.com/
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
It's a simple code move so all I've really checked is that no obvious differences
snuck in.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Mostly so I remember I checked if you do a v11 :)
