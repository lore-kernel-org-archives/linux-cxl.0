Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3843D3CF4;
	Wed, 11 Mar 2026 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773231309; cv=pass; b=FDzMUcaa3l839uudvuJJL363cMIqVKzpXVSHEMz5QRKkfISYo/84Nz3TCQD/xbA3TGayBIkwbR1RNJOYjBgLXPZ9nMqucJZfNGlry5PapD0y5QoRsIHRyCj9UChkayvcMGLWTt5hckFhdLanIQNOMlmEwhwYO5/AJXEBmuYSqhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773231309; c=relaxed/simple;
	bh=cQFdqfyRRdVnqefhpnw7NEK1LIwUldxQn135EiSSrdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fa/cBdAw/laPTbJ72j6QqQ+AeFxOpRiwPZfYLXl44Gs8qSZ57NRSVmaN6/Ds3gKRsdYah0yRLQ2y+lD1eZuJGOQMxFEEr08yiZHc+5loU5+AnGUW/CavcleJ6zHOP8fMlH7c2G/L6bD9bWKuMiME2Pn1PZBC/RwyQ3c26igLQCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=NXdVGDLc; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="NXdVGDLc"
ARC-Seal: i=1; a=rsa-sha256; t=1773231274; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XWlYtK5aK+SRvRuKztWKOi3OFFBpkKQtyz0gWXnknHvFcWeqDHL29rCGcI6oAMDaf1tui/Wf4E+LrL7M8MTGwJrs3N3hf9eKYL11Mr1/sraGrVBtb8YZuOLyQxEhkjZGIGbcHXZ/OEhxHQwB3kt6PKDfZccnKdbznn7wSU5TqOo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773231274; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Sy2m7bKImumsyawAbMNKsSZQTErbBmtwkQgsvEodRgw=; 
	b=eiwyaeGyDAsx2XBLt8aSFgjWPeehJN1Fo96fgQ2zU1Jy5XHciZU7iCzboDiPeX0oikhY/U/+zb6iSV/9RUcBmr/3xT8ykNDFbkuNu56BRFKuHyXOgt5nKGjdPVlaN+ZllGl8ZMFqPgHQ8oeG4PucPP2rWUZWHUCSkKx4GcWH1b0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773231274;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Sy2m7bKImumsyawAbMNKsSZQTErbBmtwkQgsvEodRgw=;
	b=NXdVGDLcQQQPYUq4gjS3FTd0IoiTrqYzZOYCA8/ul/ALJ6w72nl5mvXEmjA6MWPJ
	CFXRkzniOLbMUOS0TDSQpRlF7Sd2xWDnqZ7KuPK4nDljSFXZFX9N8rTbyYoA00krjjh
	EkAVyn9t0JBIEIFdB7VYbi4l4L2uq7Q6iZfE4NGg=
Received: by mx.zohomail.com with SMTPS id 1773231273311898.1297188468374;
	Wed, 11 Mar 2026 05:14:33 -0700 (PDT)
Message-ID: <1ac904b4-cc40-4586-b3fa-2b1020cca931@zohomail.com>
Date: Wed, 11 Mar 2026 20:14:28 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] cxl/port: Reset cxlmd->endpoint to -ENXIO by default
To: Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-7-94fe919a0b87@zohomail.com>
 <69b071373ffca_490a100d@dwillia2-mobl4.notmuch>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <69b071373ffca_490a100d@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112289a9defbe3617a52e8d801ee200003d266d474e9e3267afa053d7fbd8d32053abb23b9c212c2dd01d:zu08011227293f02dfc1e0e979bad2936d000047df8d1599e7d478bf77a684d5868c4eb73ec97ab75cc3e3b9:rf0801122d6829f8860ad52f83990ce93b0000a118f4f00e2611fa73211a1935710411257e9812d64332ccaf14f87eab75ae:ZohoMail
X-ZohoMailClient: External


在 2026/3/11 03:29, Dan Williams 写道:
> Li Ming wrote:
>> cxlmd->endpoint is set to -ENXIO by default, This intentional invalid
>> value ensures that any unintended access to the endpoint will be
>> detectable. But CXL driver didn't reset it to the default value when the
>> endpoint is released in delete_endpoint().
>>
>> Besides, cxlmd->endpoint is updated to point to an valid endpoint in
>> cxl_port_add(), but if the device_add() in cxl_port_add() fails, the
>> endpoint will be released, but cxlmd->endpoint remains pointing to the
>> released endpoint, it may introduce a potential use-after-free issue.
>>
>> Fixes: 3d8be8b398e3 ("cxl: Set cxlmd->endpoint before adding port device")
>> Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
> So I disagree that this is a fix. It may be a consistency change to make
> sure that all invalid ->endpoint accesses have the same result, but it
> is not a fix for any discernable end user problem.
Will change it in V2.
>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>>   drivers/cxl/core/port.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 0c5957d1d329..ec3cb62b44b7 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -834,11 +834,14 @@ static int cxl_port_add(struct cxl_port *port,
>>   			struct cxl_dport *parent_dport)
>>   {
>>   	struct device *dev __free(put_device) = &port->dev;
>> +	struct cxl_memdev *cxlmd = NULL;
>>   	int rc;
>>   
>>   	if (is_cxl_memdev(port->uport_dev)) {
>> -		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>> -		struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +		struct cxl_dev_state *cxlds;
>> +
>> +		cxlmd = to_cxl_memdev(port->uport_dev);
>> +		cxlds = cxlmd->cxlds;
>>   
>>   		rc = dev_set_name(dev, "endpoint%d", port->id);
>>   		if (rc)
>> @@ -865,8 +868,11 @@ static int cxl_port_add(struct cxl_port *port,
>>   	}
>>   
>>   	rc = device_add(dev);
>> -	if (rc)
>> +	if (rc) {
>> +		if (cxlmd)
>> +			cxlmd->endpoint = ERR_PTR(-ENXIO);
> I see no need for this. All of the upper levels paths ensure that all
> the results of setup are torn down on failure. Consider that if
> device_add() succeeds and any of the follow on functions in
> __devm_cxl_add_port() then this cleanup will also not happen.
>
> So you must rely on upper level cleanup. This is similar to the
> semantics of dev_set_drvdata(). That is only reset up after _probe()
> finishes failing.
>
>
>
> Now, if you want to do some separate cleanups in this space I would redo
> the anti-patterns of scope-based cleanup in cxl_port_alloc() and
> cxl_port_add(). cxl_port_alloc() does the "__free = NULL" anti-pattern.
> It appears to be doing that to avoid adding a DEFINE_FREE() for ida
> cleanup if the port allocation fails.
>
> Also, if the cxl_port_alloc() call became something like:
>
> struct cxl_port *port __free(put_cxl_port) = cxl_port_alloc(...)
>
> ...then I do not think cxl_port_add() would need to do the odd
> __free(put_device()) initialization without a corresponding
> get_device(). Nor the odd "dev = NULL" at the end.

To make sure that I didn't misunderstand your comment, I draft the 
following changes.

The changes also fix an issue that the unregister_port() was not invoked 
to release port if devm_cxl_link_uport() or devm_cxl_link_parent_dport() 
failed in __devm_cxl_add_port() .

If the changes are OK, I think they should be in a separate 
patchset(including reset cxlmd->endpoint to -ENXIO if adding endpoint 
failed)


diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0c5957d1d329..c1975b28b570 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -552,10 +552,13 @@ static void cxl_port_release(struct device *dev)
      xa_destroy(&port->dports);
      xa_destroy(&port->regions);
      ida_free(&cxl_port_ida, port->id);
-    if (is_cxl_root(port))
+    if (is_cxl_root(port)) {
          kfree(to_cxl_root(port));
-    else
+    } else {
+        if (is_cxl_endpoint(port))
+            to_cxl_memdev(&port->dev)->endpoint = ERR_PTR(-ENXIO);
          kfree(port);
+    }
  }

  static ssize_t decoders_committed_show(struct device *dev,
@@ -833,7 +836,7 @@ static int cxl_port_add(struct cxl_port *port,
              resource_size_t component_reg_phys,
              struct cxl_dport *parent_dport)
  {
-    struct device *dev __free(put_device) = &port->dev;
+    struct device *dev = &port->dev;
      int rc;

      if (is_cxl_memdev(port->uport_dev)) {
@@ -864,47 +867,53 @@ static int cxl_port_add(struct cxl_port *port,
              return rc;
      }

-    rc = device_add(dev);
-    if (rc)
-        return rc;
-
-    /* Inhibit the cleanup function invoked */
-    dev = NULL;
-    return 0;
+    return device_add(dev);
  }

+DEFINE_FREE(cxl_port_host_release_dr_group, struct cxl_port *,
+        if (_T) devres_release_group(port_to_host(_T), _T))
+
  static struct cxl_port *__devm_cxl_add_port(struct device *host,
                          struct device *uport_dev,
                          resource_size_t component_reg_phys,
                          struct cxl_dport *parent_dport)
  {
-    struct cxl_port *port;
+    struct cxl_port *_port;
      int rc;

-    port = cxl_port_alloc(uport_dev, parent_dport);
+    struct cxl_port *port __free(put_cxl_port) =
+        cxl_port_alloc(uport_dev, parent_dport);
      if (IS_ERR(port))
          return port;

+    void *port_dr_group __free(cxl_port_host_release_dr_group) =
+        devres_open_group(host, port, GFP_KERNEL);
+    if (!port_dr_group)
+        return ERR_PTR(-ENOMEM);
+
      rc = cxl_port_add(port, component_reg_phys, parent_dport);
      if (rc)
          return ERR_PTR(rc);

-    rc = devm_add_action_or_reset(host, unregister_port, port);
+    _port = no_free_ptr(port);
+    rc = devm_add_action_or_reset(host, unregister_port, _port);
      if (rc)
          return ERR_PTR(rc);

-    rc = devm_cxl_link_uport(host, port);
+    rc = devm_cxl_link_uport(host, _port);
      if (rc)
          return ERR_PTR(rc);

-    rc = devm_cxl_link_parent_dport(host, port, parent_dport);
+    rc = devm_cxl_link_parent_dport(host, _port, parent_dport);
      if (rc)
          return ERR_PTR(rc);

+    devres_remove_group(host, no_free_ptr(port_dr_group));
+
      if (parent_dport && dev_is_pci(uport_dev))
-        port->pci_latency = cxl_pci_get_latency(to_pci_dev(uport_dev));
+        _port->pci_latency = cxl_pci_get_latency(to_pci_dev(uport_dev));

-    return port;
+    return _port;
  }

>>   		return rc;
>> +	}
>>   
>>   	/* Inhibit the cleanup function invoked */
>>   	dev = NULL;
>> @@ -1425,7 +1431,7 @@ static void delete_endpoint(void *data)
>>   			devm_release_action(host, cxl_unlink_uport, endpoint);
>>   			devm_release_action(host, unregister_port, endpoint);
>>   		}
>> -		cxlmd->endpoint = NULL;
>> +		cxlmd->endpoint = ERR_PTR(-ENXIO);
> I also see no need for this. Either dereferencing NULL or ERR_PTR() will
> result in what is needed, a kernel crash. How the use after-free crash
> is signalled does not really matter. The only expectation that other
> code has is that "->endpoint != NULL" does not mean ->endpoint is valid.
> Nothing should care about that though because cxlmd->dev.driver is the
> authoritative gate for ->endpoint validity.
>
OK, will remove it in v2.
