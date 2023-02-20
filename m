Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E3EC636D6
	for <linux-cxl@archiver.kernel.org>; Mon, 20 Feb 2023 04:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjBTE4B (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 19 Feb 2023 23:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjBTEz5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 19 Feb 2023 23:55:57 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7954FBDE1
        for <linux-cxl@vger.kernel.org>; Sun, 19 Feb 2023 20:55:54 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31K48ucL008449;
        Mon, 20 Feb 2023 04:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=A7rsBWEPRCJEayuZrXaMs27fJzUwWUaTLOF4Okti8Qw=;
 b=VHVJfxCoxf2C7PBUhA7xqCPJXZTznSFBxdMSQI3yt56rqJdtR+UGF5/zjs/2ZEm4mG58
 O8UXplpWMia7dMLrAL2TsMISJXC4lK5N194GWxOwihWfE2W5a4pfA51VdlFcy+ZGYDys
 A37bO7nIANpYqRF/529+rlQNobTSfwO7cmPmQPZyBoYZV9Kgk8WfydA4fOThfovH0Zlp
 CbQO+1Cwudrqz4nxL6hsrNKiP+FCX+kv4TZzbNSB5xnoIMMJqCUH2HGp/dN0a6J1avCw
 wUQFjHsJ4yOjRmtPm0cB4AIoyEJ0a8SKNbg7NaNE02UmOgMDC4gNimCCmnYtEZ1Ex+TM NA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nuyk6argm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 04:55:22 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31K4hbXH024085;
        Mon, 20 Feb 2023 04:55:22 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nuyk6arg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 04:55:22 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31K2TO9G017055;
        Mon, 20 Feb 2023 04:55:21 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3ntpa6ny4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 04:55:21 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31K4tJto4129364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 04:55:20 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B96DF5805B;
        Mon, 20 Feb 2023 04:55:19 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B65CE58058;
        Mon, 20 Feb 2023 04:55:15 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.109.205.160])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Feb 2023 04:55:15 +0000 (GMT)
X-Mailer: emacs 29.0.60 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>
Cc:     "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>,
        lsf-pc@lists.linux-foundation.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Duen-wen Hsiao <duenwen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF BoF] Session for CXL memory
In-Reply-To: <CAHbLzkpJa=HYH7OAdFO6WGYXtX1Yzhv9sFE+MGfyZrd3KvUv=A@mail.gmail.com>
References: <F75E3DE0-CDF2-407A-9AF7-8EAE1D177559@bytedance.com>
 <38D49DA9-3C57-4951-8CBA-5D2BB0C40D9C@bytedance.com>
 <dd0d92fd-51dc-f5ac-26f9-7446118d654e@google.com>
 <CAHbLzkpJa=HYH7OAdFO6WGYXtX1Yzhv9sFE+MGfyZrd3KvUv=A@mail.gmail.com>
Date:   Mon, 20 Feb 2023 10:25:12 +0530
Message-ID: <87v8jx0wcv.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Gdq6GZnXqO7X3Ab7u1m4fmPu_t52Eu-C
X-Proofpoint-ORIG-GUID: vWinnm_MLpH5UWHtG0_eKaS55ObBeYh4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_01,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200041
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Yang Shi <shy828301@gmail.com> writes:

> On Sun, Jan 22, 2023 at 9:51 PM David Rientjes <rientjes@google.com> wrote:
>>
>> On Fri, 6 Jan 2023, Viacheslav A.Dubeyko wrote:
>>
>> > CC: LSF/MM/BPF mailing list. Sorry, missed the list.
>> >
>> > > On Jan 6, 2023, at 11:51 AM, Viacheslav A.Dubeyko <viacheslav.dubeyko@bytedance.com> wrote:
>> > >
>> > > Hello,
>> > >
>> > > I believe CXL memory is hot topic now. I believe we have multiple topics
>> > > for discussion. I personally would like to discuss CXL Fabric Manager
>> > > and vision of FM architecture implementation. I am going to share the topic
>> > > in separate email. I would like to suggest a special session for CXL memory
>> > > related topics.
>> > >
>> > > How everybody feels about it?
>> > >
>>
>> I think this makes a lot of sense, thanks for suggesting it.
>>
>> Should this be a BoF or just a normal topic proposal?  I assume that there
>> could be several different topics of interest all related to CXL.mem.
>>
>> Specifically interesting would be the division of work between the kernel
>> and userspace to manage memory placement on systems with locally attached
>> CXL.  And, further, what APIs userspace would have at its disposal for
>> explicit optimization of this placement that would exist beyond what is
>> available for NUMA.
>
> Yeah, in addition, how CXL hierarchy interacts with memory tiering may
> be an interesting topic too.
>
>>
>> I assume we might also want to chat about CXL 2.0 extensions that would be
>> useful, especially for cloud providers.
>>
>> I'd be happy to join in any of the proposals for these topics, just let me
>> know!
>
> +1 for me.
>

I would also be interested in finding out what we learned about the
device attributes that people want to use for building hierarchy. We
still haven't hooked up HMAT/CDAT to memory tiers. It would be good to
understand and discuss on how we should make progress here.

-aneesh
