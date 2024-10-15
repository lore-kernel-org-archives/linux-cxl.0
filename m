Received: from pv50p00im-ztbu10021601.me.com (pv50p00im-ztbu10021601.me.com [17.58.6.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DEA1D89F3
	for <linux-cxl@vger.kernel.org>; Tue, 15 Oct 2024 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990832; cv=none; b=DllSll4yBvL1T4TeNM72SOYiXWeBTRmD0DodNEVsHmMgG9uPjKgXlB6aaqHnWpUImJ5kO4vXOSQCrSX13T9kOJbQMS+RI+XUS5ECpH2RbGs9ywiYuyXxlsap8vAlHk7e/S8vkSfOBhDBkrp0XWfpJJe/YhN1PMeTiRhUE6EWz+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990832; c=relaxed/simple;
	bh=d9L0yT8fOtXjybRVnD8oTTU+gI9+CRfptCeEYfrLsMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dD6MdOYiBF5fHHz44rR0I6z5DUPrZWTPz+WQBP3EFFU2xqi8DRc3ZvSJtjpfJCOFWbLgsCpq+8uyXO5nr+TEsJf6BNk53mTHaEJNKNs5wLDRGqeAfldgqAyU3CDH1QOxkMmFV/Nnhmv+YoCqJQ3AQ9ciaNohR8fER3+YnpTuVb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=PcCtAg9i; arc=none smtp.client-ip=17.58.6.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="PcCtAg9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1728990830;
	bh=aib24ZycAHi5b2X2kQ7uIeqzAQEEIKmEe6mzLmYb6RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=PcCtAg9i+dSFjbOi/a+UYlMllP/KyZjU2eFE+8M0rxJXPTuD1mhkhT0S7mKxpl36F
	 bVOY1mrX8hIq9eo32t8vtx/DKIdDFZxVGWh902plCNMZM/JbcMrBdBTGgigC6ddEbF
	 RqyPVccs6hZIYaKvHLktfNekXF90rOinzwj4pkoaWEBMYS2eG3W2xSdoe7ukBVis/g
	 L7cGH0dENLTbDn7T+YO16xThFRUoJs/Ql3tqtZ7pCe8woMBz6iGNCoF4GskwZbrPie
	 AxNRGzGQkhrCUKZF9+YnHK3BH1DRSjLvpkFKiboEphx85BCSM9ZGi4Eby2HaiIytet
	 ulZe8r61Jp+Sw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id E427480081;
	Tue, 15 Oct 2024 11:13:46 +0000 (UTC)
Message-ID: <7dfc06f2-05cd-477b-aede-3816ef1f746d@icloud.com>
Date: Tue, 15 Oct 2024 19:13:41 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/port: Prevent out-of-order decoder allocation
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
 ira.weiny@intel.com
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, linux-cxl@vger.kernel.org
References: <172895072669.39002.9296583943188706348.stgit@dwillia2-xfh.jf.intel.com>
 <34f9ecb4-e3a3-496b-91f9-12428045d054@icloud.com>
 <670dca9fe448f_3ee229436@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <670dca9fe448f_3ee229436@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bwNHy6m6h6DV038cDFxIXhsgnDYD7HaQ
X-Proofpoint-ORIG-GUID: bwNHy6m6h6DV038cDFxIXhsgnDYD7HaQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_06,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410150077

On 2024/10/15 09:51, Dan Williams wrote:
> Zijun Hu wrote:
>> On 2024/10/15 08:06, Dan Williams wrote:
>>> With the recent change to allow out-of-order decoder de-commit it
>>> highlights a need to strengthen the in-order decoder commit guarantees.
>>> As it stands match_free_decoder() ensures that if 2 regions are racing
>>> decoder allocations the one that wins the race will get the lower id
>>> decoder, but that still leaves the race to *commit* the decoder.
>>>
>>> Rather than have this complicated case of "reserved in-order, but may
>>> still commit out-of-order", just arrange for the reservation order to
>>> match the commit-order. In other words, prevent subsequent allocations
>>> until the last reservation is committed.
>>>
>>> This precludes overlapping region creation events and requires the
>>> previous regionN to either move forward to the decoder commit stage or
>>> drop its reservation before regionN+1 can move forward. That is,
>>> provided that regionN and regionN+1 decode through the same switch port.
>>>
>>> As a side effect this allows match_free_decoder() to drop its dependency
>>> on needing write access to the device_find_child() @data parameter [1].
>>>
>>> Reported-by: Zijun Hu <zijun_hu@icloud.com>
>>> Closes: http://lore.kernel.org/20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com [1]
>>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>>> Cc: Alison Schofield <alison.schofield@intel.com>
>>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> ---
>>> This patch is incremental to "cxl: Initialization and shutdown fixes"
>>>
>>> [2]: http://lore.kernel.org/172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com
>>>
>>>  drivers/cxl/core/region.c |   43 +++++++++++++++++++++++++++++++++----------
>>>  1 file changed, 33 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 3478d2058303..dff618c708dc 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
> [..]
>>
>> Above checking seems meaningless since there are only one CLDX with ID
>> port->commit_end + 1.
>>
>> logical of below my proposal maybe what you want.
>> https://lore.kernel.org/all/4239bfd4-d5fe-4ac8-a087-9e1584765e61@icloud.com/
> 
> No. Consider that port->commit_end + 1 may walk off the end of available
> decoders.

really ?  could you like to take a example ?

let me paste the solution of below link here as well

1) it is  simpler.

2) it does need to introduce a new API device_for_each_child_reverse_from()

3) it have the minimal iterating count.

https://lore.kernel.org/all/4239bfd4-d5fe-4ac8-a087-9e1584765e61@icloud.com/

--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -796,8 +796,9 @@ static size_t show_targetN(struct cxl_region *cxlr,
char *buf, int pos)

 static int match_free_decoder(struct device *dev, void *data)
 {
+       struct cxl_port *port = to_cxl_port(dev->parent);
        struct cxl_decoder *cxld;
-       int *id = data;
+       struct device **target_dev = data;

        if (!is_switch_decoder(dev))
                return 0;
@@ -805,15 +806,19 @@ static int match_free_decoder(struct device *dev,
void *data)
        cxld = to_cxl_decoder(dev);

        /* enforce ordered allocation */
-       if (cxld->id != *id)
-               return 0;
-
-       if (!cxld->region)
-               return 1;
-
-       (*id)++;
-
-       return 0;
+       if (cxld->id == port->commit_end + 1) {
+               if (!cxld->region) {
+                       *target_dev = dev;
+                       return 1;
+               } else {
+                       dev_dbg(dev->parent,
+                               "next decoder to commit is already
reserved\n",
+                               dev_name(dev));
+                       return -ENODEV;
+               }
+       } else {
+               return cxld->flags & CXL_DECODER_F_ENABLE ? 0 : -EBUSY;
+       }
 }

 static int match_auto_decoder(struct device *dev, void *data)
@@ -839,7 +844,7 @@ cxl_region_find_decoder(struct cxl_port *port,
                        struct cxl_endpoint_decoder *cxled,
                        struct cxl_region *cxlr)
 {
-       struct device *dev;
+       struct device *dev = NULL;
        int id = 0;

        if (port == cxled_to_port(cxled))
@@ -848,8 +853,8 @@ cxl_region_find_decoder(struct cxl_port *port,
        if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
                dev = device_find_child(&port->dev, &cxlr->params,
                                        match_auto_decoder);
-       else
-               dev = device_find_child(&port->dev, &id,
match_free_decoder);
+       else if (device_for_each_child(&port->dev, &dev,
match_free_decoder) > 0)
+               get_device(dev);
        if (!dev)
                return NULL;
        /*



