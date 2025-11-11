Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1A83AA188;
	Tue, 11 Nov 2025 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872348; cv=none; b=Eo3YA/fUbHh3cwi0Yv3Rtu0DbzaTYjpbduDlfAL+YgxPRkX7pdbUB3NQiiBMIJD/gcyxxp0k9dwWxNNswt1vibuTYV5cvdzz0SHTOIljIqeY1lJu2O0iv04mspeuIcaZhL2yceKhNKbVUHf851fl/rYNvIrLW+i6KcjTE05tYjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872348; c=relaxed/simple;
	bh=Z5W88HrarkMX745HnTROo49UWd1LjK73Ftfgbdyq9Do=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQw08bTEj3rVTm0WeJzkBxgkyfIC/S2A8UAYT8ewK2cF4azhcWiEe5M2oysFW+kMR11+946xSn2UIyCqg3bWmJ2j7Ny5FCkzp9+7kDNc9VZHOeTO1uPBd8zkqWnz245Yw4sNaRFfh6gKkiC8jAWMQALBYlTumMjzN7MrEmHHZYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5Tpc2XLLzJ46Yd;
	Tue, 11 Nov 2025 22:45:12 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CB4F1400D9;
	Tue, 11 Nov 2025 22:45:43 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 14:45:42 +0000
Date: Tue, 11 Nov 2025 14:45:41 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
	<alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v4 01/14] cxl/region: Store root decoder in struct
 cxl_region
Message-ID: <20251111144541.0000714d@huawei.com>
In-Reply-To: <20251103184804.509762-2-rrichter@amd.com>
References: <20251103184804.509762-1-rrichter@amd.com>
	<20251103184804.509762-2-rrichter@amd.com>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 3 Nov 2025 19:47:42 +0100
Robert Richter <rrichter@amd.com> wrote:

> A region is always bound to a root decoder. The region's associated
> root decoder is often needed. Add it to struct cxl_region.
> 
> This simplifies the code by removing dynamic lookups and the root
> decoder argument from the function argument list where possible.
> 
> Patch is a prerequisite to implement address translation which uses
> struct cxl_region to store all relevant region and interleaving
> parameters. It changes the argument list of __construct_region() in
> preparation of adding a context argument. Additionally the arg list of
> cxl_region_attach_position() is simplified and the use of
> to_cxl_root_decoder() removed, which always reconstructs and checks
> the pointer. The pointer never changes and is frequently used. Code
> becomes more readable as this amphazises the binding between both
> objects.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Just a note to say this will (maybe just context) clash with Alejandro's rework
around construct_region_begin()

https://lore.kernel.org/all/20251110153657.2706192-19-alejandro.lucero-palau@amd.com/

Probably easy to resolve, but worth both of you being aware if you hadn't noticed
already!

Jonathan

> ---
>  drivers/cxl/core/region.c | 37 +++++++++++++++++++------------------
>  drivers/cxl/cxl.h         |  2 ++
>  2 files changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b06fee1978ba..45b1386a18d7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -495,9 +495,9 @@ static ssize_t interleave_ways_store(struct device *dev,
>  				     struct device_attribute *attr,
>  				     const char *buf, size_t len)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
> -	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region_params *p = &cxlr->params;
>  	unsigned int val, save;
>  	int rc;
> @@ -558,9 +558,9 @@ static ssize_t interleave_granularity_store(struct device *dev,
>  					    struct device_attribute *attr,
>  					    const char *buf, size_t len)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
> -	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region_params *p = &cxlr->params;
>  	int rc, val;
>  	u16 ig;
> @@ -634,7 +634,7 @@ static DEVICE_ATTR_RO(mode);
>  
>  static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct resource *res;
>  	u64 remainder = 0;
> @@ -1327,7 +1327,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	int parent_iw, parent_ig, ig, iw, rc, inc = 0, pos = cxled->pos;
>  	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
>  	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> @@ -1686,10 +1686,10 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
>  }
>  
>  static int cxl_region_attach_position(struct cxl_region *cxlr,
> -				      struct cxl_root_decoder *cxlrd,
>  				      struct cxl_endpoint_decoder *cxled,
>  				      const struct cxl_dport *dport, int pos)
>  {
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
>  	struct cxl_decoder *cxld = &cxlsd->cxld;
> @@ -1926,7 +1926,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  static int cxl_region_attach(struct cxl_region *cxlr,
>  			     struct cxl_endpoint_decoder *cxled, int pos)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_region_params *p = &cxlr->params;
> @@ -2031,8 +2031,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  			ep_port = cxled_to_port(cxled);
>  			dport = cxl_find_dport_by_dev(root_port,
>  						      ep_port->host_bridge);
> -			rc = cxl_region_attach_position(cxlr, cxlrd, cxled,
> -							dport, i);
> +			rc = cxl_region_attach_position(cxlr, cxled, dport, i);
>  			if (rc)
>  				return rc;
>  		}
> @@ -2055,7 +2054,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_region_attach_position(cxlr, cxlrd, cxled, dport, pos);
> +	rc = cxl_region_attach_position(cxlr, cxled, dport, pos);
>  	if (rc)
>  		return rc;
>  
> @@ -2351,8 +2350,8 @@ static const struct attribute_group *region_groups[] = {
>  
>  static void cxl_region_release(struct device *dev)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
>  	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	int id = atomic_read(&cxlrd->region_id);
>  
>  	/*
> @@ -2435,10 +2434,12 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
>  	 * region id allocations
>  	 */
>  	get_device(dev->parent);
> +	cxlr->cxlrd = cxlrd;
> +	cxlr->id = id;
> +
>  	device_set_pm_not_required(dev);
>  	dev->bus = &cxl_bus_type;
>  	dev->type = &cxl_region_type;
> -	cxlr->id = id;
>  
>  	return cxlr;
>  }
> @@ -2937,7 +2938,7 @@ static bool has_spa_to_hpa(struct cxl_root_decoder *cxlrd)
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_endpoint_decoder *cxled = NULL;
> @@ -3013,7 +3014,7 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  				       struct dpa_result *result)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_endpoint_decoder *cxled;
>  	u64 hpa, hpa_offset, dpa_offset;
>  	u64 bits_upper, bits_lower;
> @@ -3404,7 +3405,7 @@ static int match_region_by_range(struct device *dev, const void *data)
>  static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
>  					    struct resource *res)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_region_params *p = &cxlr->params;
>  	resource_size_t size = resource_size(res);
>  	resource_size_t cache_size, start;
> @@ -3440,9 +3441,9 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
>  }
>  
>  static int __construct_region(struct cxl_region *cxlr,
> -			      struct cxl_root_decoder *cxlrd,
>  			      struct cxl_endpoint_decoder *cxled)
>  {
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
> @@ -3534,7 +3535,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  		return cxlr;
>  	}
>  
> -	rc = __construct_region(cxlr, cxlrd, cxled);
> +	rc = __construct_region(cxlr, cxled);
>  	if (rc) {
>  		devm_release_action(port->uport_dev, unregister_region, cxlr);
>  		return ERR_PTR(rc);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 231ddccf8977..19b8b62a1322 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -521,6 +521,7 @@ enum cxl_partition_mode {
>   * struct cxl_region - CXL region
>   * @dev: This region's device
>   * @id: This region's id. Id is globally unique across all regions
> + * @cxlrd: Region's root decoder
>   * @mode: Operational mode of the mapped capacity
>   * @type: Endpoint decoder target type
>   * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
> @@ -534,6 +535,7 @@ enum cxl_partition_mode {
>  struct cxl_region {
>  	struct device dev;
>  	int id;
> +	struct cxl_root_decoder *cxlrd;
>  	enum cxl_partition_mode mode;
>  	enum cxl_decoder_type type;
>  	struct cxl_nvdimm_bridge *cxl_nvb;

