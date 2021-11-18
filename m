Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4930FC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 18 Nov 2021 22:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 294B361AA2
	for <linux-cxl@archiver.kernel.org>; Thu, 18 Nov 2021 22:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhKRWXu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 Nov 2021 17:23:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229600AbhKRWXu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 Nov 2021 17:23:50 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIME2Yk022028;
        Thu, 18 Nov 2021 22:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : to : cc :
 message-id : from : date : content-type : references :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=+g8jRT7SmVvxVxwxTnm95NImA3LioeXbZrIUBC8y9UY=;
 b=pXj+QJmuQVKIf/DSSwlB3sq+sCFkadma0vne8fE/u0CL/CEDojmYxshMrx9Xa3HDygWu
 E0RZlMKC0cLUDMQ1TNvOv8QFUhkgEwZoYUo5zGmqcygcZW/U9MbHhMsm9GaQhxP14PDt
 78ZTwIQRgQwpmAbcrrBF6uJTic1RF0v39dMH0/wbtKDLfKidY2wUNZ3zNiQMGrkOK6K6
 jeZOi7E42mt9QpeIlcYRMLBexU8P4Qz37yyRTL59HxV7d657b0xQs2KVqmdP6j5gsE6T
 RyM0ldtdNV4JUBJHDljzLniy6jl5jNEPdZzDnRtEX6hwXkfWL3V8SwIYp00XtTAsxNXe gw== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cdyeg82kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 22:20:38 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AILx5pn032705;
        Thu, 18 Nov 2021 22:20:37 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 3ca50cf26u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 22:20:37 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AIMKa5P23921024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 22:20:36 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 218B46A058;
        Thu, 18 Nov 2021 22:20:36 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F7726A047;
        Thu, 18 Nov 2021 22:20:35 +0000 (GMT)
Received: from mww0762.dal12m.mail.ibm.com (unknown [9.208.91.94])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 18 Nov 2021 22:20:35 +0000 (GMT)
In-Reply-To: <20211117173201.00002513@Huawei.com>
To:     "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Message-ID: <OF164E5BA6.E927FE73-ON00258791.0078E206-88258791.007ABBAD@ibm.com>
From:   "Saransh Gupta1" <saransh@ibm.com>
Date:   Thu, 18 Nov 2021 15:20:34 -0700
Content-Type: text/plain; charset="US-ASCII"
References: <OF255704A1.78FEF164-ON0025878E.00821084-0025878F.00015560@ibm.com><20211117165719.pqig62t5z2grgjvv@intel.com>
 <20211117173201.00002513@Huawei.com>
X-KeepSent: 164E5BA6:E927FE73-00258791:0078E206; name=$KeepSent; type=4
X-Mailer: HCL Notes Build V1101FP4_10012021 October 01, 2021
X-Disclaimed: 57103
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Krs2FawFc3X7Ca1PlNcpV6y62q0A5Kd8
X-Proofpoint-GUID: Krs2FawFc3X7Ca1PlNcpV6y62q0A5Kd8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
Subject: RE: Follow-up on the CXL discussion at OFTC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180114
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Ben and Jonathan,

Thanks for your replies. I'm looking forward to the patches.

For QEMU, I see hotplug support as an item on the list and would like to=20
start working on it. It would be great if you can provide some pointers=20
about how I should go about it.
Also, which version of kernel and QEMU (maybe Jonathan's upcoming version)=
=20
would be a good starting point for it?

Thanks,
Saransh



From:   "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
To:     "Ben Widawsky" <ben.widawsky@intel.com>
Cc:     "Saransh Gupta1" <saransh@ibm.com>, <linux-cxl@vger.kernel.org>,=20
<qemu-devel@nongnu.org>
Date:   11/17/2021 09:32 AM
Subject:        [EXTERNAL] Re: Follow-up on the CXL discussion at OFTC



On Wed, 17 Nov 2021 08:57:19 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Hi Saransh. Please add the list for these kind of questions. I've=20
converted your
> HTML mail, but going forward, the list will eat it, so please use text=20
only.
>=20
> On 21-11-16 00:14:33, Saransh Gupta1 wrote:
> >    Hi Ben,
> >=20
> >    This is Saransh from IBM. Sorry to have (unintentionally) dropped=20
out
> >    of the conversion on OFTC, I'm new to IRC.
> >    Just wanted to follow-up on the discussion there. We discussed=20
about
> >    helping with linux patches reviews. On that front, I have=20
identified
> >    some colleague(s) who can help me with this. Let me know if/how you
> >    want to proceed with that.=20
>=20
> Currently the ball is in my court to re-roll the RFC v2 patches [1]=20
based on
> feedback from Dan. I've implemented all/most of it, but I'm still=20
debugging some
> issues with the result.
>=20
> >=20
> >    Maybe not urgently, but my team would also like to get an=20
understanding
> >    of the missing pieces in QEMU. Initially our focus is on type3=20
memory
> >    access and hotplug support. Most of the work that my team does is
> >    open-source, so contributing to the QEMU effort is another possible
> >    line of collaboration.=20
>=20
> If you haven't seen it already, check out my LPC talk [2]. The QEMU=20
patches
> could use a lot of love. Mostly, I have little/no motivation until=20
upstream
> shows an interest because I don't have time currently to make sure I=20
don't break
> vs. upstream. If you want more details here, I can provide them, and I=20
will Cc
> the qemu-devel mailing list; the end of the LPC talk [2] does have a=20
list.
Hi Ben, Saransh

I have a forward port of the series + DOE etc to near current QEMU that is=
=20
lightly tested,
and can look to push that out publicly later this week.

I'd also like to push QEMU support forwards and to start getting this=20
upstream in QEMU
+ fill in some of the missing parts.

Was aiming to make progress on this a few weeks ago, but as ever other=20
stuff
got in the way.

+CC qemu-devel in case anyone else also looking at this.

Jonathan



>=20
> >=20
> >    Thanks for your help and guidance!
> >=20
> >    Best,
> >    Saransh Gupta
> >    Research Staff Member, IBM Research=20
>=20
> [1]:=20
https://lore.kernel.org/linux-cxl/20211022183709.1199701-1-ben.widawsky@int=
el.com/T/#t=20

> [2]:=20
https://www.youtube.com/watch?v=3Dg89SLjt5Bd4&list=3DPLVsQ_xZBEyN3wA8Ej4BUj=
udXFbXuxhnfc&index=3D49=20






