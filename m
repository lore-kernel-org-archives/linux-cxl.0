Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B5833B6D3;
	Fri, 29 May 2026 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070645; cv=none; b=lya9tMQHwGRSUj8qxZJ7ssHrhasgboz9hn7cFEgLnZVuLTFiRnIxJMtPwgEqqbi+PcVLqORVcV+PWVGoDeBrBTcGzSa1GQyEXw1l4HuZPJPAyeTeyI5CrvDb5LTZfBsMUMYy+i1Kys3ClOl1OJc9eLpFgYlQP4ztw3KX2wWjJgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070645; c=relaxed/simple;
	bh=BmkP21SUIF+DuAco3OxR+YP4oH0wKj44AfRYwdgDiqE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvuRS0dnqefF2Z4q4VOEC0S+S0MXjcgbOZRAh1O/qc6PTPONG7kNsv4rX7JasC7LyokiUMTfhFZtKURq7Te6YcJJfRgVjOZBjSiyM1bQbf4+QZ8WeDn5o6TnGJCbZDRqHFpIA5Uha5oRXhhWGmaIalCUYm4orCN91X17AR+0pWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miEqoNZC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miEqoNZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A66B1F00893;
	Fri, 29 May 2026 16:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780070643;
	bh=6qBznc6a6QijXfnCauAhH2VOH6sZkPkccOFwVOda7dk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=miEqoNZCCSiqX+JEe8R6+K7Vfpu5DKBqGvRMRkTalRRH2j5FP9V15L5ufngSIDKVy
	 FeyeB0NCkxK6keQExR4ubeZ9acE/H9hPG58NrPZz8gNcJtoVcXXjAU+iY/RLs9dh7w
	 CYRA7SVdTKErbv3Pv+3sQP+piQ69+/f3oe6QgaEAx6sXbLT37YxoeC8Bp3I91XfWUF
	 JFj+wAlGOaqsWFSyGOcPD9q1pmtGQR4BPTfsQVhtaXDBfTu1HkIo5VJY8IWa8Bt5P3
	 sSWq4bzhkETIpxvIfX75j4b0obwXmnXUx6WTNAb7uCcIiAPRLnt+E8Kt6NtOgvpimI
	 xwsIAwjtWITCg==
Date: Fri, 29 May 2026 17:03:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: will@kernel.org, xueshuai@linux.alibaba.com, saket.dumbre@intel.com,
 mchehab@kernel.org, dave@stgolabs.net, djbw@kernel.org, bp@alien8.de,
 tony.luck@intel.com, guohanjun@huawei.com, lenb@kernel.org,
 skhan@linuxfoundation.org, vishal.l.verma@intel.com, rafael@kernel.org,
 corbet@lwn.net, ira.weiny@intel.com, dave.jiang@intel.com,
 krzk+dt@kernel.org, robh@kernel.org, catalin.marinas@arm.com,
 alison.schofield@intel.com, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, Michael.Zhao2@arm.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Dmitry.Lamerov@arm.com,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v5 04/10] ACPI: APEI: GHES: move estatus cache helpers
Message-ID: <20260529170348.0560da0e@jic23-huawei>
In-Reply-To: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-4-2e0500d42642@arm.com>
References: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-0-2e0500d42642@arm.com>
	<20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-4-2e0500d42642@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 10:50:44 +0100
Ahmed Tiba <ahmed.tiba@arm.com> wrote:

> Relocate the estatus cache allocation and lookup helpers from ghes.c into
> ghes_cper.c. This code move keeps the logic intact while making the cache
> implementation available to forthcoming users.
> 
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>

A couple of minor things inline.

With the two I've called out tidied up
Reviewed-by: Jonathan Cameron <jic23@kernel.org>

> diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
> index 8080e0f76dac..0a117f478afb 100644
> --- a/drivers/acpi/apei/ghes_cper.c
> +++ b/drivers/acpi/apei/ghes_cper.c
> @@ -13,10 +13,14 @@
>   */
>  
>  #include <linux/err.h>
> +#include <linux/genalloc.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> +#include <linux/math64.h>
>  #include <linux/mm.h>
>  #include <linux/ratelimit.h>
> +#include <linux/rcupdate.h>
> +#include <linux/sched/clock.h>
>  #include <linux/slab.h>

> +static void ghes_estatus_cache_rcu_free(struct rcu_head *head)
> +{
> +	struct ghes_estatus_cache *cache;
> +	u32 len;
> +
> +	cache = container_of(head, struct ghes_estatus_cache, rcu);
> +	len = cper_estatus_len(GHES_ESTATUS_FROM_CACHE(cache));
> +	len = GHES_ESTATUS_CACHE_LEN(len);
> +	gen_pool_free(ghes_estatus_pool, (unsigned long)cache, len);
> +	atomic_dec(&ghes_estatus_cache_alloced);
> +}
> +
> +void
> +ghes_estatus_cache_add(struct acpi_hest_generic *generic,
> +		       struct acpi_hest_generic_status *estatus)

void ghes_estatus_cache_add(struct acpi_hest_generic *generic,
			    struct acpi_hest_generic_status *estatus)

is under 80 chars (and how you have it in the header!)

(RB assumes you fix this - or argue against perhaps because of a change in
 a future patch)

> +{
> +	unsigned long long now, duration, period, max_period = 0;
> +	struct ghes_estatus_cache *cache, *new_cache;
> +	struct ghes_estatus_cache __rcu *victim;
> +	int i, slot = -1, count;
> +
> +	new_cache = ghes_estatus_cache_alloc(generic, estatus);
> +	if (!new_cache)
> +		return;
> +
> +	rcu_read_lock();
> +	now = sched_clock();
> +	for (i = 0; i < GHES_ESTATUS_CACHES_SIZE; i++) {
> +		cache = rcu_dereference(ghes_estatus_caches[i]);
> +		if (cache == NULL) {
> +			slot = i;
> +			break;
> +		}
> +		duration = now - cache->time_in;
> +		if (duration >= GHES_ESTATUS_IN_CACHE_MAX_NSEC) {
> +			slot = i;
> +			break;
> +		}
> +		count = atomic_read(&cache->count);
> +		period = duration;
> +		do_div(period, (count + 1));
> +		if (period > max_period) {
> +			max_period = period;
> +			slot = i;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	if (slot != -1) {
If you even end up doing tidy up of this code, would be nicer to flip
the logic here and do an early return.
	if (slot == -1)
		return;
Then the rest is much less indented.

No need to do that in this series though as nothing 'wrong' with the
current code as such.

> +		/*
> +		 * Use release semantics to ensure that ghes_estatus_cached()
> +		 * running on another CPU will see the updated cache fields if
> +		 * it can see the new value of the pointer.
> +		 */
> +		victim = xchg_release(&ghes_estatus_caches[slot],
> +				      RCU_INITIALIZER(new_cache));
> +
> +		/*
> +		 * At this point, victim may point to a cached item different
> +		 * from the one based on which we selected the slot. Instead of
> +		 * going to the loop again to pick another slot, let's just
> +		 * drop the other item anyway: this may cause a false cache
> +		 * miss later on, but that won't cause any problems.
> +		 */
> +		if (victim)
> +			call_rcu(&unrcu_pointer(victim)->rcu,
> +				 ghes_estatus_cache_rcu_free);
> +	}
> +}
> diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
> index 6b7632cfaf66..1b5dbeca9bb6 100644
> --- a/include/acpi/ghes_cper.h
> +++ b/include/acpi/ghes_cper.h
> @@ -16,6 +16,7 @@
>  #ifndef ACPI_APEI_GHES_CPER_H
>  #define ACPI_APEI_GHES_CPER_H
>  
> +#include <linux/atomic.h>

Why?  Nothing in in the types used in what is added to the header needs
it - maybe I'm suffering Friday syndrome. Seems like it belongs in another
patch or in a c file rather than the header.
(RB assumes this fixed or argued against)


>  #include <linux/workqueue.h>
>  
>  #include <acpi/ghes.h>
> @@ -54,6 +55,8 @@
>  	((struct acpi_hest_generic_data *)                              \
>  	((struct ghes_vendor_record_entry *)(vendor_entry) + 1))
>  
> +extern struct gen_pool *ghes_estatus_pool;
> +
>  static inline bool is_hest_type_generic_v2(struct ghes *ghes)
>  {
>  	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
> @@ -98,5 +101,8 @@ int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
>  			u64 buf_paddr, enum fixed_addresses fixmap_idx,
>  			size_t buf_len);
>  #endif
> +int ghes_estatus_cached(struct acpi_hest_generic_status *estatus);
> +void ghes_estatus_cache_add(struct acpi_hest_generic *generic,
> +			    struct acpi_hest_generic_status *estatus);
>  
>  #endif /* ACPI_APEI_GHES_CPER_H */
> 

