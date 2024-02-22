Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [216.71.153.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762B010A05
	for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633829; cv=fail; b=fqCh8Vv1GV5aMLq8eJlJyf0lfuDux4xtEKlW20gEFGx+Mu7XFQSaidINasISIZC1Ud+i1n07Di7e0C2gWImwvNcFIY7rkJnla+S4TvzY+nrrtE6mcUrPbEHByRZrd/vTljN6A2ZrVV179aNc669TK+VmDcaRhgZqbSkFIkI1aDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633829; c=relaxed/simple;
	bh=SIXbJNl02eJao0DLGuQZggMozzKKmHu2Ecu5o5TUa8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VhXm6gfoBzUyYsCQoIO82iRg1ShkLi38etJ4wPGUHccBZ+JrrTimSGMEKHHHqOVc42h4w3YU4l3ayHjjbOW1yOz3dZpRpRtE59zW9VrFAZm/Dx+k+wN6fCcVrI3vnw3M+Gzmjig/GPu3n2RqyEi8SQqWqcKrb10lB91mGx1tLZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com; spf=pass smtp.mailfrom=seagate.com; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=Q1mC3Wtz; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=ITF9QWxP; arc=fail smtp.client-ip=216.71.153.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seagate.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="Q1mC3Wtz";
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="ITF9QWxP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1708633827; x=1740169827;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SIXbJNl02eJao0DLGuQZggMozzKKmHu2Ecu5o5TUa8U=;
  b=Q1mC3Wtz/gQQ4hQr5sXF0KeX+3HMOUa4opB42AWdeNCs5YZg/bbYgdQf
   0HIDZ/CsQIhfhXOT3XqiBfB4afWW9mcr1CcFCLBgaTUNfTCVRTJXvSs2B
   ACyLIEYazG7e/xnbMiR6jzAZA/ALSmM09yQPu+7Hw6W/htjgb1cuGFXsu
   8=;
Received: from mail-bn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.40])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 12:30:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFdqp4p7NQ3Pwjn4VYYAVRbe9GlERPJuXsjUwDkNrjf8wVRS9g7Es9yAm2gIJ/KZ6gUHFNd6pZePg4KPlbFF0NM7Y2Q+WsJo1JNmqx68z90UYLVr20fpHf1yJjdEnlLZWU7PjTG+qLQbYuL0HunkZHZxlobSaZ4advBgC17kleAl59wp2qZeyZZAICyGasi56d3aaQnW5FNo68IBhIJqWjw7Q0jueAeo4njO3zryJSdKq3Jg9rtw5gVlBBq5fRDVQhbuJuJGE9JeYRMNQfiKBpQnvtC0e2fa1vNw19dyyiGFseWB8OOR+vggv+EMMUuzbBEIC49VPpWijibK2Tp2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIXbJNl02eJao0DLGuQZggMozzKKmHu2Ecu5o5TUa8U=;
 b=nmPUURM+XDQ5n0ZIwrWGyHIACSX+zVdwb9HpUA0mEmR0sSu8rkxSYtXX1YonykGZQSxA7FPGwa8xKVo8crJFd7iu0gdZMZlYJTRK/8hzUF/4WvmEh9POPPkgMIpQ1DoVeaXQLnaXrOPi/pkrbNVziext3PMmtBkukCfptS9aJSLzLqET5mvYjn3p8w/H1zfL0Rx0pOSs/BOGfrYMWAk7Gt7XsM8PQgYnoXlaEhnrXMUccHJ3tGmREOcFZ3I8emA+LyBmHtSS40+TJ7LJZEBDH7uf/8WBClecrdSUvv7nJNXiJZrPDw2luJIA2RUXQb2vWP/szplFWnWgnN534eD8pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIXbJNl02eJao0DLGuQZggMozzKKmHu2Ecu5o5TUa8U=;
 b=ITF9QWxPPcV//+MOv6pTzSIuBnj/AKnrMmzh9fioTSimYbEjgIOeXjcVL6uzd+e/ME6Sdd/YpBLBojOMR6pVZmC3dmsNMpv8yhX+6MqlYk5cHVfG06dk5Yc4WnaPZbRumAGn89YwRyMO+j+vPgZscz5N32CPuN+/flYHjPSB6zE=
Received: from CH0PR20MB4250.namprd20.prod.outlook.com (2603:10b6:610:c4::15)
 by DM6PR20MB3507.namprd20.prod.outlook.com (2603:10b6:5:2a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Thu, 22 Feb
 2024 20:30:16 +0000
Received: from CH0PR20MB4250.namprd20.prod.outlook.com
 ([fe80::2d06:6915:2988:56cb]) by CH0PR20MB4250.namprd20.prod.outlook.com
 ([fe80::2d06:6915:2988:56cb%3]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 20:30:16 +0000
From: Hongjian Fan <hongjian.fan@seagate.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] Defer dax when CXL window is the child of the soft
 reserve region
Thread-Topic: [PATCH] Defer dax when CXL window is the child of the soft
 reserve region
Thread-Index: AQHaZa5pBGxNOzq36E6wLm6lQeTCGbEWvZaAgAARtXQ=
Date: Thu, 22 Feb 2024 20:30:16 +0000
Message-ID:
 <CH0PR20MB4250E1E8B3B8A8FC84DF56C090562@CH0PR20MB4250.namprd20.prod.outlook.com>
References: <20240222210612.15689-1-hongjian.fan@seagate.com>
 <Zdee9bI3Dnr98Jlm@aschofie-mobl2>
In-Reply-To: <Zdee9bI3Dnr98Jlm@aschofie-mobl2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Enabled=True;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SetDate=2024-02-22T20:30:15.929Z;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Name=Seagate
 Internal;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_ContentBits=0;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR20MB4250:EE_|DM6PR20MB3507:EE_
x-ms-office365-filtering-correlation-id: a8a83e6d-94eb-4e91-c34a-08dc33e5146f
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0O8hNV/wRSbvMTmk8qtH7ylsE7lM2gINpvwkId3554mzng2mkGfijTKYMuTgS8CnsOhlWhBeXN7R2B3JqrDQN2yHmwyCl+gflkOeacaDBdBtntZ8u24aA/prcuvRP6vMTzakg7mv+Kp0GnzZNDSlZcEhD/sn9KYCjq+KnrhwN4RIwDkDEim21fIOzvLhogmLQZuwiH7s/2K1Dm+Tntaxsa9hH+ThzJL0sxwvOvgvezomoee/aFLh/f38fMewhT0bOgoUO10Bas/k/Ub/aXf6dGgRYa6innAVgjQbzMzrz5/k9v73fC2stNbcgN0BPTHKzz9AL5VsJSlaZEiBV59b7IJX6GDBzQzYr/j6zTc+lde7CbMDXOH4Kxg6AfjnE2I9YS3FO0YB7c0K8NCbpRMrsg6YNsG5auey6KXyRc7ixQGRjVngulClQLw2mrJQDeYHefl9DeNxooziGwaWZcEdQySMbzgzuSPkD7ZqQUrA8QaMFBaSXniUTn8YNLU/RAOdckVJRnhHKHlKQANsoIqI5AoZ6/kPFALdEB0hK7vaPTL868ULCh0W7oic0deIH5Te8SFoMVKU87eDzKdFtXutV0oxL6sr1YSNzhxMG5Da94elCJ3zT9lj4U0rKBIgKWrR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR20MB4250.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?R21DNHdhWEp5RGJMSm5oemJTMHBhMVNqd2NhL2NhVUZ6c0FTbG4yRTRqSEVS?=
 =?utf-7?B?MlVGM2VPTXhRZXJuMktJMmloeHZWS1dkeFo4enByKy1YdkZwMXZ3bFpUSXM3?=
 =?utf-7?B?SFhacm1KaE5CSkthODJOdDRQRDdKdGRDdzJsNG11dnh5TGwwQXFybVlqZFRT?=
 =?utf-7?B?dVl5YzJuaDFnWW5HOE5BZzNJNkZETUdMWU9ncFZTc1dkZ3VSU011Q3dRRVJR?=
 =?utf-7?B?OFJTRU1CUGNrc0hISFhZREg2WXRaQVk3WkRDcGJTdExueGZLa0w2Z1YwSXhx?=
 =?utf-7?B?ZUpnNjdIVmVFdUJlNHNaMGF3aHFzVHVYTVFPWVNlSWZqb3VJcXhoVS9HNXNl?=
 =?utf-7?B?cHUxNWc0VjRaeUVXbC9vMThvQW5xekNCNGVHNWpsQkJtSEtIZ2oxV1hQNEhS?=
 =?utf-7?B?QnJ0VVFzSG5HdFNXRW1NTG9IdlQvSUZXWnhMMUJlVTJDZmhVc1pySjdzNlNa?=
 =?utf-7?B?VkorLXp4WnM3V1BXblV0Z1NvckQ4OHVnUnF4WE1WdWVhR1l1ZXdBZWtvOWpR?=
 =?utf-7?B?YzNhS3p5Y1hzTlRWcVNTWHl3NjNzWVdHNWFSeVZZSjhPS2hzUXAwRmltazY5?=
 =?utf-7?B?bXVwOFc0NHdmU1Y3Ky10a1hWeEVHYklTZmliSGc3dm80cmdPYS8vOFZCRWdw?=
 =?utf-7?B?TEJFTXR6NmZkZTJwUmQ2cmQ2VDZLZ0hoZnl2VzlvT0ozVVpPam5hajVNSmlj?=
 =?utf-7?B?REV6clpqREcySzRHb3dUaVcwMHkzclM2MGE5NFUyMGdiVWRiaTZzbURvTnFW?=
 =?utf-7?B?NUNJTjBhWXBVNHNBTDBhL1dTSHJtbkZUODZneXQ0NktMY25iTUs5cTAyRmZs?=
 =?utf-7?B?NWdFdkI5ZlJhTTgvTE0vRUJ2MlhCejR1bXBTcmxTTjJlM2QwenA0djJRZSst?=
 =?utf-7?B?ZlAwV2FKY0dRcFZ2T1h1bGMzQTRuTGZhYU0vYUM1c2pUY1lxalpFdERuM1lB?=
 =?utf-7?B?cDhHbm9idWwwTGpFaG1oZ1RrdVp6d3M5S0dmZ1ZwUS90ZDloaVVOMmxLZFlj?=
 =?utf-7?B?Uzkwb2l0QWN1eTNKajV6eTlwMVRUTGEzOVIzTUVNU2tIeUZBYzRoVmhiZ3RS?=
 =?utf-7?B?STJQcTg3ZkhsSFFlOGJ4Ky0rLWxjMkhCUDhhcjRIZEwrLVlEVVlyWTgvLzND?=
 =?utf-7?B?TVZQSThyTGhEWjVtakJzbHBwQ2ZDTHprVENLcVp5V3l2LystOFVaOW16V1FI?=
 =?utf-7?B?REkxVU5uZ0Z4d3o5R2I3eUF4NlNiZVVzT29WV2NKclhuYUZWVDZyVmRKbVRr?=
 =?utf-7?B?UE1XeDdCVmdZcjdkQld2M0dieEJUNzNJT1hPQm5rOEZCNjE5bDJEWlNUQi9t?=
 =?utf-7?B?MFd0elpQdy9hWXFUcnBmeUZLSWZKQWs1V1hNQ3NJWjJwaEUxRU9ycm9sUXhG?=
 =?utf-7?B?cjRKVXV2Q3JmaystNHpTWUduWlpKWm5SRnBFa2s0dElua1QwcEkwZ0NNbFE2?=
 =?utf-7?B?eDF6U05rcExaa3dtNHBiVW1HMHkwanAwcWRMZnprTVFLZkZ5NVhwaVZGamt4?=
 =?utf-7?B?aDNXNTZyWjB3L2RMMzlFNFozeGFmTGRxazhZYWhwWDN5bWVYUUw2dGpIMnhH?=
 =?utf-7?B?QjBvWW1wRWpIVm1kZDlLYTlKajN5aUtCMjl2NlRzRGVhdHFLTG1WOTZQRzZ2?=
 =?utf-7?B?ZFFBN3pUR3lXNEk0cVZQQlM2b2x0bmt1QmF2akFlQTJWMFp5NnhGQ3VQa0Yx?=
 =?utf-7?B?dmR1ajlmKy1wb0I1cSstaUthVGVTSlhGTXEvUjJ0enJZeE9wTjEwTHVEQUNi?=
 =?utf-7?B?aGVXSGJ3SGEycG5tenoyTFFoTTkrLXl6bnFQNWxwQVk0UTZzdzVTL2s0WlJB?=
 =?utf-7?B?QUxodFRySWhOU1NXY0NmVjB6VEtaOWJlMnNHdjZMdUFlU25sYkFXam1jVlUw?=
 =?utf-7?B?T3huWmM5NTN1VFpiNGF0NTFZWnpIZDdKeDBHR3FKLzk5VXVWNmVWck9lMFB2?=
 =?utf-7?B?Y1JBWWR6d1BibExxREpnZmljNjdlT014WnBDMmFjRUZ6OGYvOGx6LzV0QlBK?=
 =?utf-7?B?cC9rVDV0R1hqLzVJNkxzcEd3dnV4cTk4azlRM1VQZFZ1elp3aGR2blhjdmJw?=
 =?utf-7?B?MFY2ZlE4YjBiZ1Z6bkpzR0Q0QjY3S3dnYndPblJQS00yYkN3eGJPVU1xT0dJ?=
 =?utf-7?B?TGQwUy9yZUc2TW9ycnFycS92ZHFvMlk5ZEw0U2VVZ0RrRXZ2QQ==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	slBDAnKMpiSZWDdI9YRaAF0uVhH0vfqhG/RpuQTpQsCfC1tgONkIbILAZ94xpM9ecZ45wBuOm9JhVYdS4EZYovtBlIRVpwVuolWf2SH9yR2XAKNIn2wwDodN/0nLgMgQiYc/+CiwQvVYuwolRZL+LrguDmOmDwkw5dwprZIkUHTIaF3A6gvfWszq0JO73Sv2d3ESi8osvCx0DYUSNa805T5yAPNqgzjR97ivuaS7Daa6K/CqG7Nr5LTWkhpLJpptlb7cq/6i8KVvt/Wluvvpl53g4fQIr8nV46z6zUH7/gbyXsm7wDTGk8Bz4nWLrYbSedmq26qyvAEknFnBmRd/N5BUVrefj9omb0ScyxOPLNI5YZZgEFTCoGJ9Ab8cuU+1QsW8C9hNJJhpB8aOCYuzfY2gUPIeNCI7PXkDxuaqTsoi9kXeRA4C2a3xXhvXRSlFR4jnBKh7xrBi0ab9HzNgZFFbB1auqr08SyHTLAE03j4whf2tz4hIZA7yb0wq2MJ4q7HVl1QZIN8VVO0ZvJHYF8n6N27ejEOET10NSqhp/uGjF7CvLmP8q0zrHvPg3852KpW9Z2qCDC3nWR7p8aJJE1Q01Kf2wHO2pGeq5YPulaZpcIjaorAbfHggsJisWosi
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR20MB4250.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a83e6d-94eb-4e91-c34a-08dc33e5146f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 20:30:16.3058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JAzYBNjsUvUG96hAw4HV4nZbZiznq8TutxrXmkUR4Bxzpz//XUPgpjrIDcdeZOYGv4/Q/yLPOXNhmfVuYGmP6OnIsqkS5/KKWfsRtq/XkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR20MB3507

Hi Alison,

+AD4-

Seagate Internal
+AD4- On Thu, Feb 22, 2024 at 03:06:12PM -0600, Hongjian Fan wrote:
+AD4- +AD4- On some platforms, UEFI would present a single soft reserved en=
try in BIOS-e820 for multiple CXL deivces. cxl+AF8-acpi would add the CXL w=
indows as the children of the soft reserved region.
+AD4- +AD4- This change would allow proper deffering dax device creation to=
 cxl region when CXL window is the child of the soft reserved region.
+AD4-
+AD4-
+AD4- Can you explain more about how this appears as an issue.
+AD4-
+AD4- The word 'defer' is typically used to say that we are postponing
+AD4- something and will do it later. Is that the case here?


Normally dax region is created by hmem module. But when CONFIG+AF8-CXL+AF8-=
REGION is enabled, cxl module creates
and manages the dax region if it is marked as a CXL window. This means that=
 the hmem module needs to
skip the CXL window, and let the cxl+AF8-pci module to do it later.

The issue here is when multiple CXL devices are attached to the host server=
, the CXL window resource
might be inserted as a child of the soft reserved region in IO resource map=
. In this case, the original
code will not skip ( defer ) it. The dax region is still created, by hmem m=
odule, but not the cxl module.
The CXL module will not be able to manage this dax region.

Thanks,
Hongjian

+AD4-
+AD4- Thanks for helping me understand,
+AD4- Alison
