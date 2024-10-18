Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DAE20E30E
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233584; cv=fail; b=Z81ey1nLForgjpHSKJjqWOxB6iNJYoqCQfbw4skeoIxnCKZIsu0SFHQwunugxUN7Pw1SYTYN/pEedZvElPb0JoY9YbsOYEIwMdQdywvzfsgbaMfPjuBTRJo9X74bP4WDuk2mWZY/jcwr0wujyogEXwuYdbxKXLmQ/KuiqJBAXfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233584; c=relaxed/simple;
	bh=pK8qkLrjLAJQqNYUotTPBhqj8+D6KiK6e19VMh1Y26A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iCadZoqdlFGxxhQz5QksiO1f+Z6+To1uUCS9MSAB5OFbUHDswCXXvSxkWWCol2HmwwjHVMOr+4oI5ijU0lUnwUhQpwIs9ksdO6RZJeK+cmSQ8lvkqDyEgsQriGrLJvdOJBrsByb49q8PjCZhd9+UQ6go4N8vhAyBdJTL0DfE80A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=p4FmsTQv; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="p4FmsTQv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7a+q09wZBj8hS7PULRGZ38PkmdEHNJDM8h8lcSIBsBx8fN3rD6smJcBQ6J9A2+V5K4d0gOX4/Y2silfJebZQeotaYmKxNUVTM9mrBJPBAC3XN8AltkbAY6yYmJnMqwfiIh+YmqCR2LhN2V6PC0IyYPI9HlpgiTaiASHkdZyoTjppHV/KZnpRHVUQA9ogDSOrKFtXdiREfJ8pNrgqbFBhG1ZjPVwMFvGCQwx6NtRrNb2RxM5icL0eP9EGPujNZscLSdKBBKMg91N+jZ7SYBgo4Gc9xcwM/8NQvQuxnDX48sL8gukmjiD48b5CLx6oGVH4R7nZdOHAPIK6p7VPiWIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+ErsiZBo+vdxC2lCRKVzW2vvMl+19NpcGHXh/lA7CA=;
 b=UBffcjl91Cj22OWucexqDIZZd1aIadt8HRK+TEusTeu+yfHdmLc6ZXFHOtG/yRRI67hdN/dwoECApJXcuCZseSmWt8fQAqiDYGwKHOPogSEcE7cXfWbbb0UxjZohN1GMKY/XBYleMAjEWy2PfYlzGr7SocFz8C1tS5Pb5F6b3nYar9mV46UFwbttY4snyEZ/DhOpjAVvd0ltiMh6PB3gZ9WjtddN2UnCZEu9gqaZQpOYFrTkFGHe4N0IklLfFxtfFAoLICpI+ffFDZEdV6oCtMjVIt9Ol8XHNc5JWu+11J/MiMK6T7XvmopL6VS7L7tKvsNIomkj+qCeAbLvzevESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+ErsiZBo+vdxC2lCRKVzW2vvMl+19NpcGHXh/lA7CA=;
 b=p4FmsTQvWkYHymk3afq+Ijc9h3D0GsKqYM+dfBXOf5+YPpDdkOEHbf8VaC5oAzZxsPvJMaEz2ggNhZvrNSVIdhCF5azB+KpI5MFmYYgjWbNntg9oCfpTpIP5uMIwZo3t6BuamBH1+PJlta2Ep1Hm1pHjOJ+/usN15ptbnIpTTec8drrTo4VIwrL0WbfMV8cCM5q8aW1807H/tCPP/x/fe8bab28BmYSj9c88feZuoK0sSjJKePI/G6sJ8CJ78D6OWME1AtAxRCrmS63fg5t+DrVR9iWLa03t+sDBXSg90F2ZiQNU66xmREX3aJxrvzwfsZYeYLrNg9xuL/6L1IzziA==
Received: from DM6PR11CA0039.namprd11.prod.outlook.com (2603:10b6:5:14c::16)
 by BL3PR08MB7299.namprd08.prod.outlook.com (2603:10b6:208:352::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Fri, 18 Oct
 2024 06:39:37 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:14c:cafe::6b) by DM6PR11CA0039.outlook.office365.com
 (2603:10b6:5:14c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Fri, 18 Oct 2024 06:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 06:39:36 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Oct
 2024 00:39:34 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.011; Fri, 18 Oct 2024 00:39:34 -0600
From: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>,
	"john@jagalactic.com" <john@jagalactic.com>, Ajay Joshi
	<ajayjoshi@micron.com>
Subject: Re: [RFC PATCH v2 3/4] cxl: Abort background operation in case of
 timeout
Thread-Topic: [RFC PATCH v2 3/4] cxl: Abort background operation in case of
 timeout
Thread-Index: AQHbISh+lPIUKA38u0eCuJwCb2NbHg==
Date: Fri, 18 Oct 2024 06:39:34 +0000
Message-ID: <1e78d777e19344699d6d991b2114a3e1@micron.com>
References: <20241015205633.127333-1-ravis.opensrc@micron.com>
	<20241015205633.127333-4-ravis.opensrc@micron.com>
	<00a0aa82ae12450a8c690e11440c4101@micron.com>,<20241017163601.00002a1a@Huawei.com>
In-Reply-To: <20241017163601.00002a1a@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mt-whitelisted: matched
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|BL3PR08MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 4182e4b0-ab19-40bf-afc4-08dcef3fa27d
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?gqyGzJrW0gO+UDiRJGbfpZGkWP31/kSaS6W9Ltq+L9GFYchOOiDaxl1ivo?=
 =?iso-8859-1?Q?Fki0t74OI3UKZ6I6IEfwQP9fC+lsdaPI1Rpv8zJlhZSJot48I6D6vJB43B?=
 =?iso-8859-1?Q?lOK7I1F+3JREJ7dCvGpXH+qwoSgK0dkUnIb0jKxLQKA1bze6Du1RP5sNWX?=
 =?iso-8859-1?Q?kMs71gzu+qoAaWAVZHTjC5aMIT92bHrNG0e7kKXr5+ZNuRYt92T8DcAqEM?=
 =?iso-8859-1?Q?xZY2/KjstR0V92suJ6y8P3F67zaZB5opp4L2AQ3xnLHxkAsf3JrDl37Ovr?=
 =?iso-8859-1?Q?lhuuWNsLy1kaQf0cRscYMMzX6WIMR4or2Hms2z6JfLoPr1x/DROSgOCJUY?=
 =?iso-8859-1?Q?taSB4JkDJ4Be4DBrkHzD9oFZy7OIgmuZ6MXlFhCz5LFjtWBnsCer/kKOf8?=
 =?iso-8859-1?Q?+QA8n5jYQr41Obbck5TNONv+T7VGpLfMlojtKdsGYPadVGi8ondP9oLaoQ?=
 =?iso-8859-1?Q?yBb9NJHF9dadvGsOky3u41dGJsFrXRLnodxQOl74n/m1gMc9VYlu79lfoa?=
 =?iso-8859-1?Q?PxcAd+6yMI86G4Jv2hkfQ5wu2a8bm0xpe/o6G6/aTbQOrrhH6bM69gheBz?=
 =?iso-8859-1?Q?B6YIxy/Bd7KFS6S6/euT64jvSlbTgwmtUfhP2Q0kgWj+xS1B8XhMlWahsd?=
 =?iso-8859-1?Q?J14a2iPLWvyq6UUVDPm/KVuNJ+hhe5ef2q2p4WbvTB77bzXUePaiQRFA01?=
 =?iso-8859-1?Q?JoQSM56Er/2DXt6umPmzFfvHSMLJCjOIuV8O++LFaUcujo1v1+Ud0PoNwA?=
 =?iso-8859-1?Q?vRgiZ4htgsQqGC0idsH+saIMTGOISn7v1PzhwJToO6ZSo8JwLMNrhKTZy6?=
 =?iso-8859-1?Q?38EUu/IEhzioeBBI7mOtEEVr5E5R99ezQPZbp2LbzwxKHr8tYJ3gMMjGks?=
 =?iso-8859-1?Q?SPVH0YwINqf0NsRx4VLQOT6XRQrxZILJkqQT0ZBhlrG/OQf3SmjwYwOViJ?=
 =?iso-8859-1?Q?7Y3SuCr7OTQElgGGZirW5oCwcr3zKQ9ogfG4KhgdU8+lIuLBmFL5CRVe3u?=
 =?iso-8859-1?Q?MoHSPI0ZfXRuXBpp1XFnihPQtx1qslQFASZn52GLAE8Qk0USPn/vxmYoSn?=
 =?iso-8859-1?Q?jQMFgHD+cwCIOgO3vZkDtHT0peW57zK69m/ATPh5g3LeWvgMA3D/WJm59q?=
 =?iso-8859-1?Q?CqTTlsglecUQjvXTRzRsmF+6co8EH6iY9b/tt1FYArtlUm3Qh4xCtskRhF?=
 =?iso-8859-1?Q?V4RZwW+d2ldTI+JspZfODPJKK4tATjp0TbscqLIhepzHfww88T7gB07ucO?=
 =?iso-8859-1?Q?lHNi9LcKeL6GE3mgeYPgpI4n+z3ehtq9qv+U60Lpb53J8/+VSeB+Abl900?=
 =?iso-8859-1?Q?H1J+Job3DrKsmG0ISYHaNkYr9w9mlDQ3O4EnPO/rquX98mMEX4Fv+1PXii?=
 =?iso-8859-1?Q?g8Yv0zyqZ52GF4G4w7B9Q+3D3wDDtypM0pNCFx01w2HgnEKRscFAcnnznT?=
 =?iso-8859-1?Q?0N+JB7fQjXkw8o+JcyHenPdvnUkcwBBdhE2fcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 06:39:36.6329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4182e4b0-ab19-40bf-afc4-08dcef3fa27d
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR08MB7299

>On Thu, 17 Oct 2024 09:06:00 +0530
>Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>>=20
>> On Wed, 16 Oct 2024 05:00:00 +0000
>> Ravis OpenSrc <Ravis.OpenSrc@micron.com> wrote:
>>=20
>>> Adding support for aborting timed out background operations
>>>
>>> CXL r3.1 8.2.9.1.5 Request Abort Background Operation.
>>>
>>> If the status of a mailbox command is identified as timedout, an abort
>>> background operation request is sent to the device.
>>>
>>> Link:
>>>
>>https://nam10.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore
>>> .kernel.org%2Flinux-cxl%2F66035c2e8ba17_770232948b%40dwillia2-
>>xfh.jf.i
>>>
>>ntel.com.notmuch%2F&data=3D05%7C02%7Cajayjoshi%40micron.com%7C0d
>>d742041c
>>>
>>ba47ec0dbd08dceec16a02%7Cf38a5ecd28134862b11bac1d563c806f%7C0
>>%7C0%7C63
>>>
>>8647761722049771%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
>>MDAiLCJQIjoiV
>>>
>>2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D1vVK
>>PaqWSp6qT
>>> FmwsYF1z%2F7%2FdfEeVFD9cA0g1VVo00c%3D&reserved=3D0
>>>
>>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>>> Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>
>>> Signed-off-by: Ravi Shankar <ravis.opensrc@micron.com>
>>
>I was kind of expecting that we'd do this more on an ondemand basis.=20

By saying on demand, do you envision a different implementation for
abort like a sysfs interface or module param?

> So if nothing is going on, the command can have ages.

I did not quite get the comment about the ages.

>If the kernel wants to access the device and it has had a reasonable amoun=
t of
>time we abort.
>I'm not against this simpler approach though if it turns out to be good en=
ough
>for likely use cases.
>=20
>My worry is error paths crossing with a slow command where we want to find
>out what went wrong as quick as possible Is 5 seconds ok for that?  Maybe
> not.
Do you feel we need to check for "aborted" status along with background per=
centage,
to avoid waiting for 5 seconds for cases when the command has already abort=
ed.

Would something like below make sense, if not let us know your thoughts.
+static bool cxl_mbox_background_aborted(struct cxl_dev_state *cxlds)
+{
+       u64 reg;
+       u16 ret_code;
+
+       reg =3D readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
+       ret_code =3D FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK, reg);
+       if (ret_code =3D=3D CXL_MBOX_CMD_RC_ABORT)
+               return true;
+
+       return false;
+}
+
 static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
 {
        u64 reg;
@@ -316,11 +329,17 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_=
state *mds,
                timeout =3D mbox_cmd->poll_interval_ms;
                for (i =3D 0; i < mbox_cmd->poll_count; i++) {
                        if (rcuwait_wait_event_timeout(&mds->mbox_wait,
-                                      cxl_mbox_background_complete(cxlds),
+                                      (cxl_mbox_background_complete(cxlds)=
 |
+                                          cxl_mbox_background_aborted(cxld=
s)),
                                       TASK_UNINTERRUPTIBLE,
                                       msecs_to_jiffies(timeout)) > 0)
                                break;
                }
+               if (!cxl_mbox_background_aborted(cxlds)) {
+                       dev_err(dev, "aborted waiting for background (%d ms=
) by device\n",
+                               timeout * mbox_cmd->poll_count);
+                       return -ECANCELED;
+               }
>=20
>Jonathan
>>=20
>>> ---
>>>  drivers/cxl/cxlmem.h |  1 +
>>>  drivers/cxl/pci.c    | 11 +++++++++++
>>>  2 files changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h index
>>> d8c0894797ac..808fb8712145 100644
>>> --- a/drivers/cxl/cxlmem.h
>>> +++ b/drivers/cxl/cxlmem.h
>>> @@ -516,6 +516,7 @@ to_cxl_memdev_state(struct cxl_dev_state *cxlds)
>>> enum cxl_opcode {
>>>          CXL_MBOX_OP_INVALID             =3D 0x0000,
>>>          CXL_MBOX_OP_RAW                 =3D CXL_MBOX_OP_INVALID,
>>> +       CXL_MBOX_OP_REQ_ABRT_BACKGROUND_OPERATION    =3D 0x0005,
>>>          CXL_MBOX_OP_GET_EVENT_RECORD    =3D 0x0100,
>>>          CXL_MBOX_OP_CLEAR_EVENT_RECORD  =3D 0x0101,
>>>          CXL_MBOX_OP_GET_EVT_INT_POLICY  =3D 0x0102, diff --git
>>> a/drivers/cxl/pci.c b/drivers/cxl/pci.c index
>>> d5d6142f6aa3..95c1f329bca2 100644
>>> --- a/drivers/cxl/pci.c
>>> +++ b/drivers/cxl/pci.c
>>> @@ -394,6 +394,17 @@ static int cxl_pci_mbox_send(struct cxl_mailbox
>>> *cxl_mbox,
>>>
>>>          mutex_lock_io(&cxl_mbox->mbox_mutex);
>>>          rc =3D __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
>>> +       if (rc =3D=3D -ETIMEDOUT &&
>>> +               cmd->return_code =3D=3D CXL_MBOX_CMD_RC_BACKGROUND) {
>>
>>align cmd just after ( - that is c is under the r of rc After fixing the =
tabs >ting.
>>
>>> +               struct cxl_mbox_cmd abort_cmd =3D {
>>> +                       .opcode =3D
>>CXL_MBOX_OP_REQ_ABRT_BACKGROUND_OPERATION
>>> +               };
>>> +
>>> +               rc =3D __cxl_pci_mbox_send_cmd(cxl_mbox, &abort_cmd);
>>> +               if (!rc)
>>> +                       rc =3D -ECANCELED;
>>> +       }
>>> +
>>>          mutex_unlock(&cxl_mbox->mbox_mutex);
>>>
>>>          return rc;
