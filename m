Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10843451DA;
	Wed, 22 Apr 2026 23:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900004; cv=none; b=ZX8SVxQSM+JjIbauM3JLmzBEi+07XA2HZR2+7bN8a2Dxc6aOSY3Oob10h5OKpkmJXkiXrLjY1tApAtyZ+QKL1qJ6TKactRNMKWO13XZ0jG9yUVQMMY8tumIOQshzi1ecpuPnt86JQe20ifm7+ti8MFY2rjuCxSgQlRr8k+OXW7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900004; c=relaxed/simple;
	bh=qdLwwei0kncudxoxt62vIUYfKl4wbwGAPPuDpAYtsaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdRCMj1nra0wvCzHYBirwIkl6sJYx3w6YiTweH04hdyBSui0jX999zueyRvKrx/pV+pYBzivqN8MPL2RufER+E2fB6rKfUF+lY56PgG6BeKdxkQT6MUxZx8o7BwhjYS8m+kLXxgD8ybbq0uZ5HIGHQkiK9J8GvgZmnhzc3Yrlk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVlmXqV1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVlmXqV1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776900002; x=1808436002;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qdLwwei0kncudxoxt62vIUYfKl4wbwGAPPuDpAYtsaw=;
  b=QVlmXqV1RbkvGxd3HKHEfnNYqHHuuEXtYX6ccXd5I3MQE5HXpYsoppv5
   TUvgZjOQGLYp9g+op8zSDzDcNrh49m9+xSqTWQY/bRUQOPQ6ZHyyXLlN/
   ApcEB3fYp1SYDT13qIuHtNvItY6Bsk8iqDnhnz4lhWE2X7AAEgbpIG9un
   RKBtBehQ7GZhv+ykyiOgHgpDcLazTNhOyuHh3iNWNA9yywo8pTYHhPcaT
   avaM/8n+vphJznCRdOALqOWeT2Qgz++nF7JicQtaMDfJVJx3QivI6cNH+
   puNWDsTQx8Nz65gvPksDOR55+3UgOzCVBfG5gI1j1pdts7N0i8TCoR/v3
   Q==;
X-CSE-ConnectionGUID: bgkMJbuQRNW1sUHTpcTs6A==
X-CSE-MsgGUID: SyQ/Pk6NS/+fwFOjRxvh7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88169508"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="88169508"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 16:20:01 -0700
X-CSE-ConnectionGUID: 3aEcBRh2S3WMlmPp3mcn2g==
X-CSE-MsgGUID: tHN9kAimSyaHs8Z+omhXvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="225971341"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.207]) ([10.125.111.207])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 16:20:00 -0700
Message-ID: <e512dfa1-2775-4c74-a5a4-9ea766138efe@intel.com>
Date: Wed, 22 Apr 2026 16:19:56 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/region: Fix a race bug in delete_region_store
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>, Ben Widawsky <bwidawsk@kernel.org>,
 Dave Tian <daveti@purdue.edu>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260422045637.3048249-2-iam@sung-woo.kim>
 <afb81a57-0dfc-4cd4-aba8-20d572a7f5aa@intel.com>
 <CAJNyHpJVnaxixygoDVQo492am_BEBeN_MQY2Q7wxDsVwVxic+w@mail.gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAJNyHpJVnaxixygoDVQo492am_BEBeN_MQY2Q7wxDsVwVxic+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/22/26 4:13 PM, Sungwoo Kim wrote:
> On Wed, Apr 22, 2026 at 11:10 AM Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>
>>
>> On 4/21/26 9:56 PM, Sungwoo Kim wrote:
>>> devm_release_action() cannot find a matching entry in the following two
>>> race scenarios.
>>>
>>> scenario 1: delete two same regions concurrently
>>>
>>> CPU 0                     CPU 1
>>> ======                    ======
>>> delete_region_store()
>>>   cxlr = cxl_find_region_by_name()
>>>                           delete_region_store()
>>>                             cxlr = cxl_find_region_by_name()
>>>   devm_release_action()
>>>                             devm_release_action()
>>>                             // cannot find the action, WARN_ON()
>>>
>>> scenario 2: delete parent and child concurrently [1]
>>>
>>> CPU0                                    CPU1
>>> devres_release_all()
>>>    // take devres_lock
>>>    remove_nodes(devres_head) // mv to local todo
>>>    // drop devres_lock                   delete_region_store()
>>>                                            cxlr = cxl_find_region_by_name()  // success
>>>                                            devm_release_action(unregister_region)
>>>                                              devres_release()
>>>                                                devres_remove()
>>>                                                  // hold devres_lock
>>>                                                  find_dr(devres_head) // does not find it
>>>                                              WARN_ON(-ENOENT)
>>>    release_nodes() // drain todo
>>>      unregister_region(cxlr) // release() cb
>>>        device_del()
>>>
>>> To fix scenario 1, delete_region_store() directly calls
>>> unregister_region() with a test_and_set_bit(CXL_REGION_F_UNREGISTER).
>>> Also, replace devm_release_action() to devm_remove_action() as
>>> unregister_region() is now called directly.
>>>
>>> To fix scenario 2, delete_region_store() removes actions only if the
>>> driver is still attached. To ensure this, scoped_guard(device,
>>> port->uport_dev) is required to check port->uport_dev->driver.
>>> To hold this lock, a workqueue is required for a clean context.
>>
>> Thank you Sungwoo for the fix. Given that this deals with 2 different scenarios, can this be split into 2 patches each address a scenario uniquely?
> 
> Sure thing. I think reforming it into a single patchset is better than
> splitting it into two distinct patches, since they are highly
> relevant.
> 

Yes. A series of 2 patches would make sense.

>>
>> For scenario 2, can you please put a bit more context in its commit log to explain why a workqueue is needed from your discussion with Dan for future readers?
>>
>> Also for the commit log please add context on how these issues were found and what impact was observed and how that effects a user. This information necessary for the Fixes tag dispatching upstream.
> 
> Will do in v3. How do you think about impact? I guess the impact (the
> warning in devm_release_action()) is low, since the region has already
> been released. So, it does not affect users, except for a negligible
> warning message.

If that is the case, then put the above explanation in the commit log. Impact low. 

> 
> Apart from the impact, this bug is a case study in cleaning up a
> resource, especially when it can be cleaned up by both upper and lower
> devices. Since CXL is hierarchical, existing and future CXL components
> may have a similar issue with different impacts and need to adopt this
> pattern to avoid the same race condition. I'm personally interested in
> finding bugs in this direction :)
> 
> Thank you!
> Sungwoo.
> 
>>
>> Thanks!
>>
>> DJ
>>
>>>
>>> Splat:
>>>
>>> WARNING: drivers/base/devres.c:824 at devm_release_action drivers/base/devres.c:824 [inline], CPU#0: syz.1.12224/47589
>>> WARNING: drivers/base/devres.c:824 at devm_release_action+0x2b2/0x360 drivers/base/devres.c:817, CPU#0: syz.1.12224/47589
>>>
>>> [1] https://lore.kernel.org/linux-cxl/20260310183644.4rwc7ilmzy4t5xp6@offworld/
>>>
>>> Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
>>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>>> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
>>> ---
>>> V1: https://lore.kernel.org/linux-cxl/20260308185958.2453707-2-iam@sung-woo.kim/
>>> V1->V2:
>>> - Made devm_remove_action() asynchronous.
>>> - Made unregister_region() idempotent.
>>> - Addressed Dan's comments and added the suggested-by tag.
>>>
>>>  drivers/cxl/core/region.c | 45 ++++++++++++++++++++++++++++++++++++---
>>>  drivers/cxl/cxl.h         |  8 +++++++
>>>  2 files changed, 50 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index e50dc716d4e8..64db0d332c13 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -39,6 +39,7 @@
>>>  static nodemask_t nodemask_region_seen = NODE_MASK_NONE;
>>>
>>>  static struct cxl_region *to_cxl_region(struct device *dev);
>>> +static void remove_devm_actions_work(struct work_struct *work);
>>>
>>>  #define __ACCESS_ATTR_RO(_level, _name) {                            \
>>>       .attr   = { .name = __stringify(_name), .mode = 0444 },         \
>>> @@ -2543,6 +2544,9 @@ static void unregister_region(void *_cxlr)
>>>       struct cxl_region_params *p = &cxlr->params;
>>>       int i;
>>>
>>> +     if (test_and_set_bit(CXL_REGION_F_UNREGISTER, &cxlr->flags))
>>> +             return;
>>> +
>>>       device_del(&cxlr->dev);
>>>
>>>       /*
>>> @@ -2589,6 +2593,8 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
>>>       dev->type = &cxl_region_type;
>>>       cxl_region_setup_flags(cxlr, &cxlrd->cxlsd.cxld);
>>>
>>> +     INIT_WORK(&cxlr->remove_work, remove_devm_actions_work);
>>> +
>>>       return cxlr;
>>>  }
>>>
>>> @@ -2831,20 +2837,53 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>>>       return to_cxl_region(region_dev);
>>>  }
>>>
>>> +static void remove_devm_actions_work(struct work_struct *work)
>>> +{
>>> +     struct cxl_region *cxlr = container_of(work, typeof(*cxlr), remove_work);
>>> +     struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>>> +     struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
>>> +
>>> +     if (test_and_set_bit(CXL_REGION_F_DEVM_REMOVE, &cxlr->flags)) {
>>> +             put_device(&cxlr->dev);
>>> +             return;
>>> +     }
>>> +
>>> +     scoped_guard(device, port->uport_dev) {
>>> +             if (port->uport_dev->driver)
>>> +                     devm_remove_action(port->uport_dev, unregister_region, cxlr);
>>> +     }
>>> +
>>> +     put_device(&cxlr->dev);
>>> +}
>>> +
>>> +static int remove_devm_actions(struct cxl_region *cxlr)
>>> +{
>>> +     if (!schedule_work(&cxlr->remove_work))
>>> +             return -EBUSY;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>  static ssize_t delete_region_store(struct device *dev,
>>>                                  struct device_attribute *attr,
>>>                                  const char *buf, size_t len)
>>>  {
>>>       struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
>>> -     struct cxl_port *port = to_cxl_port(dev->parent);
>>>       struct cxl_region *cxlr;
>>> +     int rc;
>>>
>>> +     /* remove_devm_actions_work() will put cxlr->dev. */
>>>       cxlr = cxl_find_region_by_name(cxlrd, buf);
>>>       if (IS_ERR(cxlr))
>>>               return PTR_ERR(cxlr);
>>>
>>> -     devm_release_action(port->uport_dev, unregister_region, cxlr);
>>> -     put_device(&cxlr->dev);
>>> +     unregister_region(cxlr);
>>> +
>>> +     rc = remove_devm_actions(cxlr);
>>> +     if (rc) {
>>> +             put_device(&cxlr->dev);
>>> +             return rc;
>>> +     }
>>>
>>>       return len;
>>>  }
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index 1297594beaec..75ec292a9f42 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -447,6 +447,12 @@ struct cxl_region_params {
>>>   */
>>>  #define CXL_REGION_F_NORMALIZED_ADDRESSING 3
>>>
>>> +/* Indicate that this region is being unregistered to prevent a race. */
>>> +#define CXL_REGION_F_UNREGISTER 4
>>> +
>>> +/* Indicate that this region called devm_remove_action. */
>>> +#define CXL_REGION_F_DEVM_REMOVE 5
>>> +
>>>  /**
>>>   * struct cxl_region - CXL region
>>>   * @dev: This region's device
>>> @@ -462,6 +468,7 @@ struct cxl_region_params {
>>>   * @coord: QoS access coordinates for the region
>>>   * @node_notifier: notifier for setting the access coordinates to node
>>>   * @adist_notifier: notifier for calculating the abstract distance of node
>>> + * @remove_work: trigger the remove action in a safe context to acquire locks
>>>   */
>>>  struct cxl_region {
>>>       struct device dev;
>>> @@ -477,6 +484,7 @@ struct cxl_region {
>>>       struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>>>       struct notifier_block node_notifier;
>>>       struct notifier_block adist_notifier;
>>> +     struct work_struct remove_work;
>>>  };
>>>
>>>  struct cxl_nvdimm_bridge {
>>
>>
> 

