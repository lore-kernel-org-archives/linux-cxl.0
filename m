Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AC23A9626;
	Tue,  3 Feb 2026 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770131779; cv=pass; b=mZNdSED0vwLvXKw7D8hSrW/mQhyQLIUdJ8NMBUkHq7r/WkubZySiPqZjvOBburR50dN7Yd8g98oOJQHmekO2i/p/xluU6BuHtHBymEILKQtaQUkCOqdVkuoHHfjudRPWnwETlWWqMD55lf/BDmde658HnBRZMTaMRBCrFhctur0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770131779; c=relaxed/simple;
	bh=IOuX+8M7n9udpYBz1BpSfFKcLD3r0iyYSIoL/XV8nLg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=sTR7cjVlFyum2L9MVARgF2mvpvFC242Ojo7HcqIlHEuCljyQoJLuhapa15AXDSwz8cLTwrcHFjXJ4VOIAtbNRB31mBr6GA+q9adDCdFIibNU9Pe4X0L8mom1GVlTDwRcPAQZ0LL5BsEnD/D2++knW572BdL1UNPYeGO5Z6yVLP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=QoTOtH7A; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="QoTOtH7A"
ARC-Seal: i=1; a=rsa-sha256; t=1770131758; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MYO2FetqqsroMff+CoW99mCFhvy/gkL3ZTcOJ9yhIMNGnh+1i+ythdj/UMrieXCHav8AD/VMkxnlrZqzBJMnBEUYgtGerYp3rmKin/1ALlB88Dle8XQ4CpAwvCzFqcqd+nophhG9elLPpIrqYpgEatQNgQX0KTNq6v2AhvC6nOI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770131758; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qG+6L1IUJ0V76uqaB7zn7xnGuuMZTrbdn/1GHy/VSis=; 
	b=ED+HREeuUgsFks9AZGG0Mar1JuusMuEpOiGrsQsnVZS8L16J68/8nlswa1n3hExeFMe+cs5eGi886lVRJxW+z0Kmnnz6Mlq+BlNQI74g3rQrPJFl3/2P4kk+9JutiGibtqc3LB6IPApGXV3sE7UG6KYYwRyyNjvoSN+gGqgKKU8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770131758;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=qG+6L1IUJ0V76uqaB7zn7xnGuuMZTrbdn/1GHy/VSis=;
	b=QoTOtH7AFnI2Lp7Ox8QwjG0iv5U5SJrEUkXAPOBTdeyxpJQG8npqOwq7H5xc+yEs
	a7GR3vyVAN2p4Ipc3qKkQR8PagXLTB7gY24bXzq74qR6eoQ/r5QyeQ3IQ5cyVFmJVVv
	QW7q0vL1KNuZIvItGPqrEHrHm8qmqQzNTSTInq08=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1770131756105966.2434021149797; Tue, 3 Feb 2026 07:15:56 -0800 (PST)
Received: from  [188.253.115.11] by mail.zoho.com
	with HTTP;Tue, 3 Feb 2026 07:15:56 -0800 (PST)
Date: Tue, 03 Feb 2026 23:15:56 +0800
From: Li Ming <ming.li@zohomail.com>
To: "danjwilliams" <dan.j.williams@intel.com>
Cc: "dave" <dave@stgolabs.net>,
	"jonathan.cameron" <jonathan.cameron@huawei.com>,
	"dave.jiang" <dave.jiang@intel.com>,
	"alison.schofield" <alison.schofield@intel.com>,
	"vishal.l.verma" <vishal.l.verma@intel.com>,
	"ira.weiny" <ira.weiny@intel.com>,
	"linux-cxl" <linux-cxl@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19c2413143b.107b011e88026.6653143171898793206@zohomail.com>
In-Reply-To: <69813ac070f79_55fa1005c@dwillia2-mobl4.notmuch>
References: <20260201093002.1281858-1-ming.li@zohomail.com>
 <20260201093002.1281858-2-ming.li@zohomail.com> <69813ac070f79_55fa1005c@dwillia2-mobl4.notmuch>
Subject: Re: [PATCH 1/2] cxl/core: Set cxlmd->endpoint to NULL by default
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr0801122cc2dc09abf80d4400035bcd6f000011c5d2370d2274a1454d1817bb5d40d5c62366ef41311dc4d15e846da505:zu0801122793fda7542b80488e322a9358000028e4f50ccbf8e739bbc05350480c4d503af6a0c61ef3831af8:rf08011232e24782a8703c53447aadc7d20000ef0673d7af62e0ed7f96ed2e36dd9bb73f5ba20d4e9e278f5d5c4330dc3776b991965162:ZohoMail




From:  <dan.j.williams@intel.com>
To: "Li Ming"<ming.li@zohomail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>, <alison.schofield@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dan.j.williams@intel.com>
Cc: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Li Ming"<ming.li@zohomail.com>
Date: Tue, 03 Feb 2026 08:01:04 +0800
Subject: Re: [PATCH 1/2] cxl/core: Set cxlmd->endpoint to NULL by default

 > Li Ming wrote:
 > > CXL testing environment can trigger following trace
 > > 
 > >  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000092: 0000 [#1] SMP KASAN NOPTI
 > >  KASAN: null-ptr-deref in range [0x0000000000000490-0x0000000000000497]
 > >  RIP: 0010:cxl_dpa_to_region+0x105/0x1f0 [cxl_core]
 > >  Call Trace:
 > >   <TASK>
 > >   cxl_event_trace_record+0xd1/0xa70 [cxl_core]
 > >   __cxl_event_trace_record+0x12f/0x1e0 [cxl_core]
 > >   cxl_mem_get_records_log+0x261/0x500 [cxl_core]
 > >   cxl_mem_get_event_records+0x7c/0xc0 [cxl_core]
 > >   cxl_mock_mem_probe+0xd38/0x1c60 [cxl_mock_mem]
 > 
 > Hooray for unit tests, but I wonder why this failure is so reliable for
 > you and absent for me? I retried with latest cxl/next, no luck.
 > 
 > No matter, it still looks like something worth addressing, but not with
 > setting ->endpoint to NULL.
 > 
 > >   platform_probe+0x9d/0x130
 > >   really_probe+0x1c8/0x960
 > >   __driver_probe_device+0x187/0x3e0
 > >   driver_probe_device+0x45/0x120
 > >   __device_attach_driver+0x15d/0x280
 > > 
 > > commit 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
 > > initializes cxlmd->endpoint to ERR_PTR(-ENXIO) in cxl_memdev_alloc().
 > > However, cxl_dpa_to_region() treats a non-NULL cxlmd->endpoint as a
 > > valid endpoint.
 > > 
 > > Across the CXL core, endpoint availability is generally determined by
 > > checking whether it is NULL. Align with this convention by initializing
 > > cxlmd->endpoint to NULL by default.
 > > 
 > > Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
 > > Signed-off-by: Li Ming <ming.li@zohomail.com>
 > > ---
 > >  drivers/cxl/core/memdev.c | 2 +-
 > >  1 file changed, 1 insertion(+), 1 deletion(-)
 > > 
 > > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
 > > index af3d0cc65138..41a507b5daa4 100644
 > > --- a/drivers/cxl/core/memdev.c
 > > +++ b/drivers/cxl/core/memdev.c
 > > @@ -675,7 +675,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 > >      cxlmd->id = rc;
 > >      cxlmd->depth = -1;
 > >      cxlmd->attach = attach;
 > > -    cxlmd->endpoint = ERR_PTR(-ENXIO);
 > > +    cxlmd->endpoint = NULL;
 > 
 > So, this does not look like a fix to me, it looks like a bug report
 > against all the code paths that want to assume that a mere NULL check of
 > ->endpoint is sufficient.
 > 
 > I think this unintentional ERR_PTR() trip hazard is now a *feature* in
 > retrospect to catch those cases. If something depends on ->endpoint
 > being valid, it depends on ->endpoint *staying* valid.
 > 
 > A proposed fix for this case is below (passes cxl_test), and if other
 > ERR_PTR() crashes show up I expect they need similar inspection. This
 > probably wants additional cleanup to consolidate boiler-plate and make
 > the critical change to cxl_dpa_to_region() easier to see:
 > 
Hi Dan,

Thanks for your proposal, I think your change can solve this problem too.
But the change is a lot, and need more time to review all driver code to confirm
if there are other places needed such checking. (I found that cxl_reset_done also needs some changes like you mentioned)
Maybe we can consider my change as a quick fix? Then I can prepare a new patchset for the consolidation.

Ming

 > -- 8< --
 > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
 > index 422531799af2..e652980098cf 100644
 > --- a/drivers/cxl/core/core.h
 > +++ b/drivers/cxl/core/core.h
 > @@ -39,7 +39,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
 >  int cxl_region_init(void);
 >  void cxl_region_exit(void);
 >  int cxl_get_poison_by_endpoint(struct cxl_port *port);
 > -struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
 > +struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa);
 >  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 >             u64 dpa);
 >  
 > @@ -50,7 +50,7 @@ static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
 >      return ULLONG_MAX;
 >  }
 >  static inline
 > -struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
 > +struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa)
 >  {
 >      return NULL;
 >  }
 > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
 > index ef202b34e5ea..610ed6744ddc 100644
 > --- a/drivers/cxl/cxlmem.h
 > +++ b/drivers/cxl/cxlmem.h
 > @@ -864,7 +864,7 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 >  void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 >                    unsigned long *cmds);
 >  void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
 > -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 > +void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 >                  enum cxl_event_log_type type,
 >                  enum cxl_event_type event_type,
 >                  const uuid_t *uuid, union cxl_event *evt);
 > diff --git a/include/linux/device.h b/include/linux/device.h
 > index 0be95294b6e6..4fafee80524b 100644
 > --- a/include/linux/device.h
 > +++ b/include/linux/device.h
 > @@ -911,6 +911,7 @@ static inline void device_unlock(struct device *dev)
 >  }
 >  
 >  DEFINE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T))
 > +DEFINE_GUARD_COND(device, _intr, device_lock_interruptible(_T), _RET == 0)
 >  
 >  static inline void device_lock_assert(struct device *dev)
 >  {
 > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
 > index fa6dd0c94656..7b923408b6c5 100644
 > --- a/drivers/cxl/core/mbox.c
 > +++ b/drivers/cxl/core/mbox.c
 > @@ -886,7 +886,7 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 >  }
 >  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, "CXL");
 >  
 > -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 > +void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 >                  enum cxl_event_log_type type,
 >                  enum cxl_event_type event_type,
 >                  const uuid_t *uuid, union cxl_event *evt)
 > @@ -913,6 +913,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 >           * translations. Take topology mutation locks and lookup
 >           * { HPA, REGION } from { DPA, MEMDEV } in the event record.
 >           */
 > +        guard(device)(&cxlmd->dev);
 >          guard(rwsem_read)(&cxl_rwsem.region);
 >          guard(rwsem_read)(&cxl_rwsem.dpa);
 >  
 > @@ -961,7 +962,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 >  }
 >  EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, "CXL");
 >  
 > -static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 > +static void __cxl_event_trace_record(struct cxl_memdev *cxlmd,
 >                       enum cxl_event_log_type type,
 >                       struct cxl_event_record_raw *record)
 >  {
 > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
 > index af3d0cc65138..d2bee5608e50 100644
 > --- a/drivers/cxl/core/memdev.c
 > +++ b/drivers/cxl/core/memdev.c
 > @@ -331,6 +331,10 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 >  {
 >      int rc;
 >  
 > +    ACQUIRE(device_intr, devlock)(&cxlmd->dev);
 > +    if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
 > +        return rc;
 > +
 >      ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
 >      if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 >          return rc;
 > @@ -355,6 +359,7 @@ int cxl_clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
 >      if (!IS_ENABLED(CONFIG_DEBUG_FS))
 >          return 0;
 >  
 > +    device_lock_assert(&cxlmd->dev);
 >      lockdep_assert_held(&cxl_rwsem.dpa);
 >      lockdep_assert_held(&cxl_rwsem.region);
 >  
 > @@ -400,6 +405,10 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 >  {
 >      int rc;
 >  
 > +    ACQUIRE(device_intr, devlock)(&cxlmd->dev);
 > +    if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
 > +        return rc;
 > +
 >      ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
 >      if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 >          return rc;
 > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
 > index 96888d87a8df..a7d391757e16 100644
 > --- a/drivers/cxl/core/region.c
 > +++ b/drivers/cxl/core/region.c
 > @@ -2936,7 +2936,7 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
 >      return 1;
 >  }
 >  
 > -struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
 > +struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa)
 >  {
 >      struct cxl_dpa_to_region_context ctx;
 >      struct cxl_port *port;
 > @@ -2944,8 +2944,12 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
 >      ctx = (struct cxl_dpa_to_region_context) {
 >          .dpa = dpa,
 >      };
 > +
 > +    device_lock_assert(&cxlmd->dev);
 > +    if (!cxlmd->dev.driver)
 > +        return NULL;
 >      port = cxlmd->endpoint;
 > -    if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
 > +    if (cxl_num_decoders_committed(port))
 >          device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
 >  
 >      return ctx.cxlr;
 > @@ -4004,10 +4008,9 @@ static int validate_region_offset(struct cxl_region *cxlr, u64 offset)
 >      return 0;
 >  }
 >  
 > -static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
 > +static int region_poison_lookup(struct cxl_region *cxlr, u64 offset,
 > +                struct dpa_result *result)
 >  {
 > -    struct dpa_result result = { .dpa = ULLONG_MAX, .cxlmd = NULL };
 > -    struct cxl_region *cxlr = data;
 >      int rc;
 >  
 >      ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
 > @@ -4022,8 +4025,8 @@ static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
 >          return -EINVAL;
 >  
 >      offset -= cxlr->params.cache_size;
 > -    rc = region_offset_to_dpa_result(cxlr, offset, &result);
 > -    if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
 > +    rc = region_offset_to_dpa_result(cxlr, offset, result);
 > +    if (rc || !result->cxlmd || result->dpa == ULLONG_MAX) {
 >          dev_dbg(&cxlr->dev,
 >              "Failed to resolve DPA for region offset %#llx rc %d\n",
 >              offset, rc);
 > @@ -4031,7 +4034,43 @@ static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
 >          return rc ? rc : -EINVAL;
 >      }
 >  
 > -    return cxl_inject_poison_locked(result.cxlmd, result.dpa);
 > +    return 0;
 > +}
 > +
 > +static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
 > +{
 > +    struct dpa_result result1 = { .dpa = ULLONG_MAX };
 > +    struct dpa_result result2 = { .dpa = ULLONG_MAX };
 > +    struct cxl_region *cxlr = data;
 > +    struct cxl_memdev *cxlmd;
 > +    int rc;
 > +
 > +    rc = region_poison_lookup(cxlr, offset, &result1);
 > +    if (rc)
 > +        return rc;
 > +
 > +    cxlmd = result1.cxlmd;
 > +    ACQUIRE(device_intr, devlock)(&cxlmd->dev);
 > +    if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
 > +        return rc;
 > +
 > +    ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
 > +    if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 > +        return rc;
 > +
 > +    ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
 > +    if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
 > +        return rc;
 > +
 > +    offset -= cxlr->params.cache_size;
 > +    rc = region_offset_to_dpa_result(cxlr, offset, &result2);
 > +    if (rc || memcmp(&result1, &result2, sizeof(result1) != 0)) {
 > +        dev_dbg(&cxlr->dev,
 > +            "Error injection raced region reconfiguration: %d\n", rc);
 > +        return rc ? rc : -ENXIO;
 > +    }
 > +
 > +    return cxl_inject_poison_locked(result1.cxlmd, result1.dpa);
 >  }
 >  
 >  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
 > @@ -4039,10 +4078,21 @@ DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
 >  
 >  static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
 >  {
 > -    struct dpa_result result = { .dpa = ULLONG_MAX, .cxlmd = NULL };
 > +    struct dpa_result result1 = { .dpa = ULLONG_MAX };
 > +    struct dpa_result result2 = { .dpa = ULLONG_MAX };
 >      struct cxl_region *cxlr = data;
 > +    struct cxl_memdev *cxlmd;
 >      int rc;
 >  
 > +    rc = region_poison_lookup(cxlr, offset, &result1);
 > +    if (rc)
 > +        return rc;
 > +
 > +    cxlmd = result1.cxlmd;
 > +    ACQUIRE(device_intr, devlock)(&cxlmd->dev);
 > +    if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
 > +        return rc;
 > +
 >      ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
 >      if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 >          return rc;
 > @@ -4051,20 +4101,15 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
 >      if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
 >          return rc;
 >  
 > -    if (validate_region_offset(cxlr, offset))
 > -        return -EINVAL;
 > -
 >      offset -= cxlr->params.cache_size;
 > -    rc = region_offset_to_dpa_result(cxlr, offset, &result);
 > -    if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
 > +    rc = region_offset_to_dpa_result(cxlr, offset, &result2);
 > +    if (rc || memcmp(&result1, &result2, sizeof(result1) != 0)) {
 >          dev_dbg(&cxlr->dev,
 > -            "Failed to resolve DPA for region offset %#llx rc %d\n",
 > -            offset, rc);
 > -
 > -        return rc ? rc : -EINVAL;
 > +            "Error clearing raced region reconfiguration: %d\n", rc);
 > +        return rc ? rc : -ENXIO;
 >      }
 >  
 > -    return cxl_clear_poison_locked(result.cxlmd, result.dpa);
 > +    return cxl_clear_poison_locked(result1.cxlmd, result1.dpa);
 >  }
 >  
 >  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
 > -- 
 > 2.52.0
 > 
 > 

