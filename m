Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF663F4E5
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDB4A7
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 05:57:36 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5CRn6Zj0z6K6Rc;
	Wed, 11 Oct 2023 20:55:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 13:57:33 +0100
Date: Wed, 11 Oct 2023 13:57:32 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v10 06/22] base/node / acpi: Change 'node_hmem_attrs' to
 'access_coordinates'
Message-ID: <20231011135732.00005c35@Huawei.com>
In-Reply-To: <169698633344.1991735.1745201451434063116.stgit@djiang5-mobl3>
References: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
	<169698633344.1991735.1745201451434063116.stgit@djiang5-mobl3>
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

On Tue, 10 Oct 2023 18:05:33 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Dan Williams suggested changing the struct 'node_hmem_attrs' to
> 'access_coordinates' [1]. The struct is a container of r/w-latency and
> r/w-bandwidth numbers. Moving forward, this container will also be used by
> CXL to store the performance characteristics of each link hop in
> the PCIE/CXL topology. So, where node_hmem_attrs is just the access
> parameters of a memory-node, access_coordinates applies more broadly
> to hardware topology characteristics. The observation is that seemed like
> an excercise in having the application identify "where" it falls on a
> spectrum of bandwidth and latency needs. For the tuple of read/write-latency
> and read/write-bandwidth, "coordinates" is not a perfect fit. Sometimes it
> is just conveying values in isolation and not a "location" relative to
> other performance points, but in the end this data is used to identify the
> performance operation point of a given memory-node. [2]
> 
> Link: http://lore.kernel.org/r/64471313421f7_1b66294d5@dwillia2-xfh.jf.intel.com.notmuch/
> Link: https://lore.kernel.org/linux-cxl/645e6215ee0de_1e6f2945e@dwillia2-xfh.jf.intel.com.notmuch/
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Whilst the coordinates analogy is a bit weak in my mind, I guess I'll get used
to it.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/acpi/numa/hmat.c |   20 ++++++++++----------
>  drivers/base/node.c      |   12 ++++++------
>  include/linux/node.h     |    8 ++++----
>  3 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index bba268ecd802..f9ff992038fa 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -62,7 +62,7 @@ struct memory_target {
>  	unsigned int memory_pxm;
>  	unsigned int processor_pxm;
>  	struct resource memregions;
> -	struct node_hmem_attrs hmem_attrs[2];
> +	struct access_coordinate coord[2];
>  	struct list_head caches;
>  	struct node_cache_attrs cache_attrs;
>  	bool registered;
> @@ -227,24 +227,24 @@ static void hmat_update_target_access(struct memory_target *target,
>  {
>  	switch (type) {
>  	case ACPI_HMAT_ACCESS_LATENCY:
> -		target->hmem_attrs[access].read_latency = value;
> -		target->hmem_attrs[access].write_latency = value;
> +		target->coord[access].read_latency = value;
> +		target->coord[access].write_latency = value;
>  		break;
>  	case ACPI_HMAT_READ_LATENCY:
> -		target->hmem_attrs[access].read_latency = value;
> +		target->coord[access].read_latency = value;
>  		break;
>  	case ACPI_HMAT_WRITE_LATENCY:
> -		target->hmem_attrs[access].write_latency = value;
> +		target->coord[access].write_latency = value;
>  		break;
>  	case ACPI_HMAT_ACCESS_BANDWIDTH:
> -		target->hmem_attrs[access].read_bandwidth = value;
> -		target->hmem_attrs[access].write_bandwidth = value;
> +		target->coord[access].read_bandwidth = value;
> +		target->coord[access].write_bandwidth = value;
>  		break;
>  	case ACPI_HMAT_READ_BANDWIDTH:
> -		target->hmem_attrs[access].read_bandwidth = value;
> +		target->coord[access].read_bandwidth = value;
>  		break;
>  	case ACPI_HMAT_WRITE_BANDWIDTH:
> -		target->hmem_attrs[access].write_bandwidth = value;
> +		target->coord[access].write_bandwidth = value;
>  		break;
>  	default:
>  		break;
> @@ -701,7 +701,7 @@ static void hmat_register_target_cache(struct memory_target *target)
>  static void hmat_register_target_perf(struct memory_target *target, int access)
>  {
>  	unsigned mem_nid = pxm_to_node(target->memory_pxm);
> -	node_set_perf_attrs(mem_nid, &target->hmem_attrs[access], access);
> +	node_set_perf_attrs(mem_nid, &target->coord[access], access);
>  }
>  
>  static void hmat_register_target_devices(struct memory_target *target)
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 493d533f8375..cb2b6cc7f6e6 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -74,14 +74,14 @@ static BIN_ATTR_RO(cpulist, CPULIST_FILE_MAX_BYTES);
>   * @dev:	Device for this memory access class
>   * @list_node:	List element in the node's access list
>   * @access:	The access class rank
> - * @hmem_attrs: Heterogeneous memory performance attributes
> + * @coord:	Heterogeneous memory performance coordinates
>   */
>  struct node_access_nodes {
>  	struct device		dev;
>  	struct list_head	list_node;
>  	unsigned int		access;
>  #ifdef CONFIG_HMEM_REPORTING
> -	struct node_hmem_attrs	hmem_attrs;
> +	struct access_coordinate	coord;
>  #endif
>  };
>  #define to_access_nodes(dev) container_of(dev, struct node_access_nodes, dev)
> @@ -167,7 +167,7 @@ static ssize_t property##_show(struct device *dev,			\
>  			   char *buf)					\
>  {									\
>  	return sysfs_emit(buf, "%u\n",					\
> -			  to_access_nodes(dev)->hmem_attrs.property);	\
> +			  to_access_nodes(dev)->coord.property);	\
>  }									\
>  static DEVICE_ATTR_RO(property)
>  
> @@ -187,10 +187,10 @@ static struct attribute *access_attrs[] = {
>  /**
>   * node_set_perf_attrs - Set the performance values for given access class
>   * @nid: Node identifier to be set
> - * @hmem_attrs: Heterogeneous memory performance attributes
> + * @coord: Heterogeneous memory performance coordinates
>   * @access: The access class the for the given attributes
>   */
> -void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs,
> +void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>  			 unsigned int access)
>  {
>  	struct node_access_nodes *c;
> @@ -205,7 +205,7 @@ void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs,
>  	if (!c)
>  		return;
>  
> -	c->hmem_attrs = *hmem_attrs;
> +	c->coord = *coord;
>  	for (i = 0; access_attrs[i] != NULL; i++) {
>  		if (sysfs_add_file_to_group(&c->dev.kobj, access_attrs[i],
>  					    "initiators")) {
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 427a5975cf40..25b66d705ee2 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -20,14 +20,14 @@
>  #include <linux/list.h>
>  
>  /**
> - * struct node_hmem_attrs - heterogeneous memory performance attributes
> + * struct access_coordinate - generic performance coordinates container
>   *
>   * @read_bandwidth:	Read bandwidth in MB/s
>   * @write_bandwidth:	Write bandwidth in MB/s
>   * @read_latency:	Read latency in nanoseconds
>   * @write_latency:	Write latency in nanoseconds
>   */
> -struct node_hmem_attrs {
> +struct access_coordinate {
>  	unsigned int read_bandwidth;
>  	unsigned int write_bandwidth;
>  	unsigned int read_latency;
> @@ -65,7 +65,7 @@ struct node_cache_attrs {
>  
>  #ifdef CONFIG_HMEM_REPORTING
>  void node_add_cache(unsigned int nid, struct node_cache_attrs *cache_attrs);
> -void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs,
> +void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>  			 unsigned access);
>  #else
>  static inline void node_add_cache(unsigned int nid,
> @@ -74,7 +74,7 @@ static inline void node_add_cache(unsigned int nid,
>  }
>  
>  static inline void node_set_perf_attrs(unsigned int nid,
> -				       struct node_hmem_attrs *hmem_attrs,
> +				       struct access_coordinate *coord,
>  				       unsigned access)
>  {
>  }
> 
> 
> 

