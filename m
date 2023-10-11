Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438D1A27C
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AA1A7
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 06:10:56 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5Cn467NTz6J6CY;
	Wed, 11 Oct 2023 21:10:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 14:10:53 +0100
Date: Wed, 11 Oct 2023 14:10:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v10 15/22] cxl: Add support for _DSM Function for
 retrieving QTG ID
Message-ID: <20231011141052.00002156@Huawei.com>
In-Reply-To: <169698638898.1991735.17757157241242765633.stgit@djiang5-mobl3>
References: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
	<169698638898.1991735.17757157241242765633.stgit@djiang5-mobl3>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 10 Oct 2023 18:06:28 -0700
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

A few comments inline. Main one that needs fixing is out dated docs.

Jonathan

> ---
> v10:
> - Remove allocation in _DSM handler. Change input parameter to request
>   number of ids to return.
> - Removed Jonathan's review tag due to significant changes
> v9:
> - Fix input to 4 ints instead of using buffers. (Dan)
> - Remove all endien conversion inside acpi handling code. (Dan)
> v8:
> - Change DSM return package parsing to use integers.
> v7:
> - Fix stray lines in commit log. (Jonathan)
> v5:
> - Make the helper a callback for the CXL root. (Dan)
> - Drop the addition of core/acpi.c. (Dan)
> - Add endiness handling. (Jonathan)
> - Refactor error exits. (Jonathan)
> - Update evaluate function description. (Jonathan)
> - Make uuid static. (Dan)
> v2:
> - Reorder var declaration and use C99 style. (Jonathan)
> - Allow >2 ACPI objects in package for future expansion. (Jonathan)
> - Check QTG IDs against MAX QTG ID provided by output package. (Jonathan)
> ---
>  drivers/cxl/acpi.c      |  131 ++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/core/port.c |   41 +++++++++++++--
>  drivers/cxl/cxl.h       |   25 +++++++++
>  3 files changed, 189 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 2034eb4ce83f..a84fef73f8ce 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c


> /**
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
> + * suitable to least suitable. Return first QTG ID.

Return count of QTG IDs I think..

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
> +	int rc = 0;

Trivial but I think it's always set below so doesn't need init here.


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
> +	if (pkg->type != ACPI_TYPE_INTEGER) {
> +		rc = -ENXIO;
> +		goto out;
> +	}
> +
> +	max_qtg = pkg->integer.value;
> +
> +	/* It's legal to have 0 QTG entries */

If that's the case, why not return 0 and make it the callers problem to deal
with this. Seems odd to have the retrieval function return an error for
something the spec says is fine.

> +	pkg_entries = out_obj->package.count;
> +	if (pkg_entries <= 1) {
> +		rc = -EEXIST;
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

