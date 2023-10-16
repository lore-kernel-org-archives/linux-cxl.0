Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B9916438
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7E8F1
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 03:56:18 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8DV30bqNz6JB04;
	Mon, 16 Oct 2023 18:52:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 16 Oct
 2023 11:56:14 +0100
Date: Mon, 16 Oct 2023 11:56:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v11 15/22] cxl: Add support for _DSM Function for
 retrieving QTG ID
Message-ID: <20231016115614.00003d60@Huawei.com>
In-Reply-To: <169713690074.2205276.14288360792472635288.stgit@djiang5-mobl3>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
	<169713690074.2205276.14288360792472635288.stgit@djiang5-mobl3>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 12 Oct 2023 11:55:00 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> CXL spec v3.0 9.17.3 CXL Root Device Specific Methods (_DSM)
> 
> Add support to retrieve QTG ID via ACPI _DSM call. The _DSM call requires
> an input of an ACPI package with 4 dwords (read latency, write latency,
> read bandwidth, write bandwidth). The call returns a package with 1 WORD
> that provides the max supported QTG ID and a package that may contain 0 or
> more WORDs as the recommended QTG IDs in the recommended order.
> 
> Create a cxl_root container for the root cxl_port and provide a callback
> ->get_qos_class() in order to retrieve the QoS class. For the ACPI case,  
> the _DSM helper is used to retrieve the QTG ID and returned. A
> devm_cxl_add_root() function is added for root port setup and registration
> of the cxl_root callback operation(s).
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Hi Dave,

One totally trivial bikeshedding comment inline. Perhaps can be tweaked by
Dan if he's otherwise happy with this series.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>  
> +/**
> + * cxl_acpi_evaluate_qtg_dsm - Retrieve QTG ids via ACPI _DSM
> + * @handle: ACPI handle
> + * @coord: performance access coordinates
> + * @entries: number of QTG IDs to return
> + * @qos_class: int array provided by caller to return QTG IDs
> + *
> + * Return: number of QTG IDs returned, or -errno for errors
> + *
> + * Issue QTG _DSM with accompanied bandwidth and latency data in order to get
> + * the QTG IDs that are suitable for the performance point in order of most
> + * suitable to least suitable. Write back array of QTG IDs and return the
> + * actual number of QTG IDs written back.
> + */
> +static int
> +cxl_acpi_evaluate_qtg_dsm(acpi_handle handle, struct access_coordinate *coord,
> +			  int entries, int *qos_class)
> +{
> +	union acpi_object *out_obj, *out_buf, *pkg;
> +	union acpi_object in_array[4] = {
> +		[0].integer = { ACPI_TYPE_INTEGER, coord->read_latency },
> +		[1].integer = { ACPI_TYPE_INTEGER, coord->write_latency },
> +		[2].integer = { ACPI_TYPE_INTEGER, coord->read_bandwidth },
> +		[3].integer = { ACPI_TYPE_INTEGER, coord->write_bandwidth },
> +	};
> +	union acpi_object in_obj = {
> +		.package = {
> +			.type = ACPI_TYPE_PACKAGE,
> +			.count = 4,
> +			.elements = in_array,
> +		},
> +	};
> +	int count, pkg_entries, i;
> +	u16 max_qtg;
> +	int rc;
> +
> +	if (!entries)
> +		return -EINVAL;
> +
> +	out_obj = acpi_evaluate_dsm(handle, &acpi_cxl_qtg_id_guid, 1, 1, &in_obj);
> +	if (!out_obj)
> +		return -ENXIO;
> +
> +	if (out_obj->type != ACPI_TYPE_PACKAGE) {
> +		rc = -ENXIO;
> +		goto out;
> +	}
> +
> +	/* Check Max QTG ID */
> +	pkg = &out_obj->package.elements[0];

Totally trivial, but pkg seems an odd name for something that isn't a package.

> +	if (pkg->type != ACPI_TYPE_INTEGER) {
> +		rc = -ENXIO;
> +		goto out;
> +	}
> +
> +	max_qtg = pkg->integer.value;
> +
> +	/* It's legal to have 0 QTG entries */
> +	pkg_entries = out_obj->package.count;
> +	if (pkg_entries <= 1) {
> +		rc = 0;
> +		goto out;
> +	}
> +
> +	/* Retrieve QTG IDs package */
> +	pkg = &out_obj->package.elements[1];
> +	if (pkg->type != ACPI_TYPE_PACKAGE) {
> +		rc = -ENXIO;
> +		goto out;
> +	}
> +
> +	pkg_entries = pkg->package.count;
> +	count = min(entries, pkg_entries);
> +	for (i = 0; i < count; i++) {
> +		u16 qtg_id;
> +
> +		out_buf = &pkg->package.elements[i];
> +		if (out_buf->type != ACPI_TYPE_INTEGER) {
> +			rc = -ENXIO;
> +			goto out;
> +		}
> +
> +		qtg_id = out_buf->integer.value;
> +		if (qtg_id > max_qtg)
> +			pr_warn("QTG ID %u greater than MAX %u\n",
> +				qtg_id, max_qtg);
> +
> +		qos_class[i] = qtg_id;
> +	}
> +	rc = count;
> +
> +out:
> +	ACPI_FREE(out_obj);
> +	return rc;
> +}
> +



