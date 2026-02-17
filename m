Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [139.138.35.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92D04C6C
	for <linux-cxl@vger.kernel.org>; Tue, 17 Feb 2026 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.138.35.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771342373; cv=fail; b=fpVYFsftgQRdq096X+F7X/i734J7GqSyErpwj/arFYfjkKFXG0EZ2zO8XIWlTb6GbWK34ZTth7SbQRl4jb7T1297X/dQoeTXcsHRQy5Mrg6MI31KN0G9NmDtcXu9BmIMfrcH9eE1ihjFoSmHnHx3eFsRoM3BlUfQZp2wn2LwsqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771342373; c=relaxed/simple;
	bh=bi34VtEmynxOMa87BrTmJ3CIvgC7U4LQuzE/2g7frig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U25mrND/J+AkidwC4JW957ZPLg6r5eHf7Wc+h61WRIfGlxn0sStv2KYsjcBaujjMqetePHifI7p3MpqfmBD/B0DEJFHDzt/ce9K5XO9OmfY7LLKVKHonOroIWIVtUbgU6qC56fnaZl1ns/HmbxXXVvzcnW3ocVhXORHvBVZ/51Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com; spf=pass smtp.mailfrom=seagate.com; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=Ye31tVQJ; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=JMQUCFyu; arc=fail smtp.client-ip=139.138.35.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seagate.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="Ye31tVQJ";
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="JMQUCFyu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1771342371; x=1802878371;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bi34VtEmynxOMa87BrTmJ3CIvgC7U4LQuzE/2g7frig=;
  b=Ye31tVQJxLKCYXGhUzKkueWIBB5gKALWkqPTa3w2+eoxutxfkGqueFhZ
   CBjo4aHDkksLKhnDw1cBnIiNqavajS8Pzwg+n0ah6qSpUeMfI+B6RcQaO
   RnTcZ5/rDhq8zuwksZeKrw1RtOmEZAr9t/kjRf2SDorDJSuGlzAw/0Ji8
   U=;
X-CSE-ConnectionGUID: vY1fRUNqT9SEwriDVdu+og==
X-CSE-MsgGUID: IZOJ6B+RSAO/G1JyRxjcVA==
Received: from mail-dm2pr04cu00305.outbound.protection.outlook.com (HELO DM2PR04CU003.outbound.protection.outlook.com) ([40.93.13.61])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 17 Feb 2026 07:31:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfG9jdE12K6gj+5AqpUVE6gHcbd3+0OMss9LSwKvzNqas0BfDkeroJALz3SVDkPSxkv+ATBtp5h1a9W7EwD3KBJFg+o+pBs/5kl9SaWJKng+ph1pqRvwlw27FOwRNspjkFxWNvCJwMzrh1Eu8gepT70wY4qtlZWULqkb7mbsOUEmCQlJAXgpB17kBYU6mXBZfQharkWXmG/hAI4aAtge7OQ1kUlQtYVNC4T9qIdTW4db57SqpiWOrTaUJnTx8ujsnbk1jtebZmy6EVV0OLveSlwPWd5b1BiOLjA7Fs5fkuoS/dNDbRvlmRkskZ3LTUuPLFme0ev+nSHv/8fBhCbccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bi34VtEmynxOMa87BrTmJ3CIvgC7U4LQuzE/2g7frig=;
 b=musG4QhhkRRitKzrrIrcE7peDAJtGaXVNA81cJ2tS6eNZXuWbDKKRJ2PNzyw7PufONxZ4poWcjCR2CM6c0GCL6lTTjBerczpZdCH+JXilhncnndGlxCyaxi3k6gOfftra4Op0kgrJoKTbOxjjsQbZNFBI+agIhOw5apnLe2HEiRXezBAdmXNT/FeTKaQTvgVqrG6EwGjZBgU+ZOh+CgvGb1bWX7azZ9SXULSvF077ca+e/Cfj0IWCoswpOx6P2OF+OOkW9ULdOW2DntsH63yU9RVrWHFdDAEJQvoYOB6e3BCnC5SUKk8TU3c3VLmkk5v4//55X5exGka9dsbeIcUUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bi34VtEmynxOMa87BrTmJ3CIvgC7U4LQuzE/2g7frig=;
 b=JMQUCFyup/GvWAU1oVwo2RkLL4xdEaUogrJbgUsXhzQwRSY7j8z3YwoTlsCkoCaxhvWdgTaA7bjkplNlXKcQak8mTdHR7GywRiVm9f9RBGY/+IvJvXM52SFeZctummu2DG8r8xSX3oAoCx/RLPoxEMyzIuZXxaiRkknxvcjbGnM=
Received: from CY5PR20MB4747.namprd20.prod.outlook.com (2603:10b6:930:29::20)
 by DS2PR20MB7562.namprd20.prod.outlook.com (2603:10b6:8:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 15:31:41 +0000
Received: from CY5PR20MB4747.namprd20.prod.outlook.com
 ([fe80::6208:6f12:f785:f936]) by CY5PR20MB4747.namprd20.prod.outlook.com
 ([fe80::6208:6f12:f785:f936%4]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 15:31:41 +0000
From: Hongjian Fan <hongjian.fan@seagate.com>
To: Gregory Price <gourry@gourry.net>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: cgroup support for DCD
Thread-Topic: cgroup support for DCD
Thread-Index: AQHcl48tTxXHbq2jYUSBoqBO3TOJkLV3a5GAgA+nQKI=
Date: Tue, 17 Feb 2026 15:31:41 +0000
Message-ID:
 <CY5PR20MB4747B26D29D76514E88A4BA8906DA@CY5PR20MB4747.namprd20.prod.outlook.com>
References:
 <CY5PR20MB47474A4D5CFA5E7284328F6A9066A@CY5PR20MB4747.namprd20.prod.outlook.com>
 <aYdlv6Q8h3g2BHrn@gourry-fedora-PF4VCD3F>
In-Reply-To: <aYdlv6Q8h3g2BHrn@gourry-fedora-PF4VCD3F>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Enabled=True;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SetDate=2026-02-17T15:31:40.801Z;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Name=Seagate
 General
 Information;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_ContentBits=1;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR20MB4747:EE_|DS2PR20MB7562:EE_
x-ms-office365-filtering-correlation-id: e812807b-8055-4a7c-b5f3-08de6e39a617
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?qkLbONr/sZ2ss6l6roZXuULtAsavppB9zAfPocLxnL88ru0rf8rjkPbJh8?=
 =?iso-8859-1?Q?17zf/XoxrLCPcSWTWspfNv+x4a8If4EvVnkkhpsn+rel/ssIaXB+G9VWVg?=
 =?iso-8859-1?Q?RYzBUSCSR9tsKpa5ICwWkSqQv0J5Cu4N2ztNSV97yXVnpkNKYO1kr7Iw0G?=
 =?iso-8859-1?Q?FlDFzeM9TM0RBksbCHWmY2Wgix8SM4JTtacUKCzpFpqp7ETgFx7jtF4faQ?=
 =?iso-8859-1?Q?6nECzG/9PaSXCH/BfIk/1GaQB7n9oqj8VNzuTdyseHsQA/pOWYFYATab4l?=
 =?iso-8859-1?Q?rrGrVNZCwkoKdH2/OZfNJHepYpsrcp1Xf8E3O+cDhp9jlLOEZRIj0MlJz0?=
 =?iso-8859-1?Q?2nG9yauBLnTANbqPJC2qyHPtYUsi+ek06c/N3QZAkXG3+usowDJJEm0IRR?=
 =?iso-8859-1?Q?6MQXtxNo096qlMg600E6jMmuVEyrtmKx4z/cmqWr2dSr3or2cX9pDFIM2G?=
 =?iso-8859-1?Q?mInF1xY4Zrg1W6VXaxl9cmZPwXbm3Na+H/oes+aesrLx44K+GZah43zzGf?=
 =?iso-8859-1?Q?zOqri8Z5B4y43X0D7c5Lgwf5XdKOjlcHhqXiy5/B/aS5II9xwvwXnb8HNR?=
 =?iso-8859-1?Q?bXUuCN+fSRjLXGioTwAAqvgM/7Pppd7o+whDvQL4b+KG8AgWAhWv5vw8z4?=
 =?iso-8859-1?Q?Gq3o0IH5fflozT+aIxJbbZFfk3VyiMDjwnmvZ7rCNTQmQw7A2gq2tk2kAA?=
 =?iso-8859-1?Q?bkjkXtXqNDePCX+OS4jZIeNM1JfGAXmCvyRO3zbM9CsdcR9crDNFd/iNgp?=
 =?iso-8859-1?Q?+iKpgFI/BahvVuLXccFzjU2fvEAO/rqiAgqcgZDJSutjvX/1SHlTOwh2Uk?=
 =?iso-8859-1?Q?RCObno3n3h0O0p2QfmQlv1kO2jIgN0JgMmaMCRZemEje9jpo51gWf5+cWI?=
 =?iso-8859-1?Q?vRbd0Cs8uaaeJbbYMnAt4hdaWZDICpimtsAymuWvc5Wx/1vI39lr7rxnwu?=
 =?iso-8859-1?Q?ZweNYpeJ04SysBZvzVi6/VzGEAIUOvYMtW2B1CgJ/TRTBn4rlhHMbhpRL2?=
 =?iso-8859-1?Q?wIDBp9KiGRHKLescP9JNnO+GJpbTEpCWbSpN6UQpx/8NIIOwjjdPORFnG6?=
 =?iso-8859-1?Q?ieZI7CETNkqWjo/KRvrbauwWIsIPbUJ1Bh7Uk6VpaQ/ebyDykdiCh081cj?=
 =?iso-8859-1?Q?HeQiVyI+Fm8irD4xUSM30+6n8zRUdYcSH2kWW+CdzlxDV7vH4G8C2JUlHd?=
 =?iso-8859-1?Q?ty1tVINKNfBzJrfnv3bwG1/vS7hK9SxuOJ8KGVR5KX7uLSiDnzMQMUPqRX?=
 =?iso-8859-1?Q?pJzHP9KpkQ9QjJ9GZAzS4VxnyiyXqAo595Tcvofe1JXLJSndltc+s7Hp9H?=
 =?iso-8859-1?Q?LX2ATdcmd4UDc+kf0qROAmuZJyiMLFW60Pl7Urk4ZZhXT9/TCnlhYYQ5HM?=
 =?iso-8859-1?Q?JhFpdpX+Y64SQSJU72SviP7UkMfsOpZmD3hhdpWnl0LfPz2bJCA9xraLuJ?=
 =?iso-8859-1?Q?3LmWeDhE+FseebLE9feg2kpXoPM36xCy1TYqyeoobu8tW/K94SdaWajPFg?=
 =?iso-8859-1?Q?05S9fYc74SxTo24pfxjFLPBwMvKxsVteWPjin6HNIh57i72v6PPjlIm7MD?=
 =?iso-8859-1?Q?x0jS72Iqtu56T4QiZMpgjLivz0Yv4K1qc2PxfsZxfSji4ODNIK1bYC7AFC?=
 =?iso-8859-1?Q?pmlqauSMYA7gtam6aTgZP+TQyWuPtoaeFh2Mc84Wqz8dmGp0a/OsoVBvkp?=
 =?iso-8859-1?Q?TPeAC6pz0fjtVa0qE24=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR20MB4747.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?DxzZkuOk7SLa6Jac26COFEiUZxHF+/A64Auxin1fBhWzzaZEp3Hs8F1l5z?=
 =?iso-8859-1?Q?T+D0eXTnzPp80OdWjZeQeK50ZcBnFO9oX4Wk+SSK3FG6X+QwePTuSQ1aZn?=
 =?iso-8859-1?Q?P5SVbvmDMnH4FnvWoSuaFVt82ROS/RUQgfrNckkugz0iane6Jduf/IlcPx?=
 =?iso-8859-1?Q?HmAfTBQLMjdUwU0AqFHjZf++XYQybHGHZ8F+tOiASDFGEJopNgUurnM8B1?=
 =?iso-8859-1?Q?BWPtrpbWQgz4v/fNZRdN/5n3zWvR7fzvM9DAyQrvGrIgy+fiU2HniZ19nU?=
 =?iso-8859-1?Q?wwuvp80TxTBjNmahPnwcKHGYc1hgLUAZsaSNwAq8K/JHh+Ti5z7SBIJZaf?=
 =?iso-8859-1?Q?H6y2o7daOmGAnook0VTvlq5E3C/el9W1FG7BADmfFAGVLgG0C8YwBq6h3X?=
 =?iso-8859-1?Q?tAh8cjYzCO23Iogpe18uoBSQoofS5PyTEeIx4M4lO70gY2qg9Xf7gu0XKF?=
 =?iso-8859-1?Q?HWli99TSMKhNFKgUOeEXeEe0tKu/pqyJDkkOwHk8E+p36lig1rcf36hta3?=
 =?iso-8859-1?Q?B6YxQroXfnR+25jFQsdXm19pK0xidhYfauoe50BoDnGURBe5CjkGk4nNPH?=
 =?iso-8859-1?Q?cCOkJlJAGvGgoe15SkuZmj7BF9q5KpQgV5UFPAJcw4qxct+Fun0N9eVESO?=
 =?iso-8859-1?Q?76whFmQRSh1F3ok09OyXjtgV05b7asoWcs8aW5M/TECkxqQbllgoGMPL0c?=
 =?iso-8859-1?Q?IGN/XmU27ph5+qh+u6aNJcWle7a7xuvG/oDRrlb+X99cG1xQZzX2mlZ2hm?=
 =?iso-8859-1?Q?HHl9xMPcMY5mg6geN5VibSFvVESVWh77YnF7QO5goc6lr0hK6NNQR76ie1?=
 =?iso-8859-1?Q?RwZtg6uw+TsVZ/xflgW3ArZkrY7OQm14Q5Q46P6RdATUl7VDNCXvFeSxt1?=
 =?iso-8859-1?Q?/ZyCR5HQhOwks3KiSz2Ls+TG/3ytDu+oa1tUGnGWFcQUn8B0qJO/8gZ2sM?=
 =?iso-8859-1?Q?NNegtCR1RfoaQsMEgrj6ggufjp28cOLDeqcYf6x+pdLQiZShvgQV1f9Ps/?=
 =?iso-8859-1?Q?ru501SYM9CtEYP3JrGrcweFdVzBeapt9bOW/5DM9o+mqkV4FL03xt1Lu/b?=
 =?iso-8859-1?Q?6QZEM5CNuR09giO1E3PKfXY9rCaE+KDW8Sk7H+wCO7ZWjYarTD2nqRn+Lc?=
 =?iso-8859-1?Q?JjvvacKU6eLJ1CO2ADtx99/pkonZfT8UdI3Tnm2bOC1boNlR+uP8SEFjX/?=
 =?iso-8859-1?Q?puNqMt/LMxNze7akBaD+OLTRimKOR/NaaJE+A0MiDsR/EzF2RB09s0fXZX?=
 =?iso-8859-1?Q?TOhF1ZMNA8Ein1p6rPO/XgUj2+YjLzD4khMf1Luk2dzIKAhoJlpwMyfVGi?=
 =?iso-8859-1?Q?O+hLqwMxbCVD4510UAGFbE9BgFvpG/MjsuiOcL1qjYQ65rYQoIlFQvFzKe?=
 =?iso-8859-1?Q?WKoHij7lq7U0QYPdapp0oAZVGX7KAMUCH5iDPxrhqKJcaGLCTFYDKoerTq?=
 =?iso-8859-1?Q?Uq7R5PaKNDllRbjxg85zmHbQEkW7+LaGoSvMueCFFaPf6zTEl9EjE+2AtL?=
 =?iso-8859-1?Q?Y22gGk49DhlCVZZnrfaMtFfn5eCGTSxG/noeTbrRloQbonK5Uvhd51mzN2?=
 =?iso-8859-1?Q?LFKylijKhjjJxx/EEvSepACn0prDbGa9RkUPrnERpLRfuIWSG8PZvTEvEc?=
 =?iso-8859-1?Q?yHkfR6HE4OyqVVdS6sEBTpvapR66hm1nkqnJOcSJO5DcQ0ZSiJktk/aws3?=
 =?iso-8859-1?Q?dNp4Na2UuVgqW4tHDXP4T7aYTtIC8d8wkVYJHawXXiLYr5Jq2Nu+Ohcoq7?=
 =?iso-8859-1?Q?i9+0J2ysQCIgmoklQs3ZMdJmedDe0PH5O3bRMRL5gOOicK9EluMxtjRC9/?=
 =?iso-8859-1?Q?bAB1o50gBw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MV5+pjveVgl8i30QiUl0yV80qXhZLp2ClT2IB58VW01frsURTsBhR4VeWDW/xUYd3ZjoUp9H2ehbdktWeqhu5pqNOOXIsV0AHQ+FvptkAPAJhXz+JdtDVpcnl7nBQKFRl3khGSormNfokMshfopcjQg5lKCpTnwJ2Ef4Qoojg4sSbSy54lcoBAHtgamSyWlksNg+w/ewDsD2y7M1qF29+I9esMEijIJtGB1eJKatjYdAvj8cLhiAXUFazQSvM0nPfTj8z6GjsAcA6zewC277jGH6DNVOsRwLjz3uLH6xdDk1EL80r2z8iInFFM5ds5bjPW0hc0QDKwNbSsDvb2M2ktLd4OS40Fa/jbLD14CXiuutgugEhdeuGFjrG4cJCpUs/xqpsEY/BJHfElaOFomo4G9MnqDfpmw6dbfIpwLlYzhDo/p/gL9W5lRbHXYPM61XV/IT87AUGZHuALUmVq5+cbnhJm80btBXdCNpcQPOXvFmKWjsHqQB32rG/dfeyr8xnGxIqCWsTer+rOj0XhV/HbJ2LOPlllcts3ddHzY9RGlJ8H+/DcNjPJ7PHXbZPkTte5dmQvfAgM3XX1AE99fV9DYeHGohWFmwxhHQhBEx6xFT9aslDXggO/IfdoYQh+mX
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR20MB4747.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e812807b-8055-4a7c-b5f3-08de6e39a617
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 15:31:41.1386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RwXFyp4GBL4fTl7fUw5WitSV9/7wWuGkBp9Ks7l7HHbkT0DB4u3V+HsOAfjAYFbvYWeS7/DkavkhN+8Mgj4yiU9srahVNiJNgOD+JyLY+IU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR20MB7562

Hi Gregory,=0A=
=0A=
> What you're describing is just producing more normal sysram numa nodes=0A=
> and providing them to isolated cgroups.=A0 This can, almost, already be=
=0A=
> done with existing infrastructure.=0A=
=0A=
Thanks for the reply. Would you mind of sharing a bit of more information o=
n how to?=0A=
Much Appreciated!=0A=
=0A=
-Hongjian Fan=0A=
=0A=
________________________________________=0A=
From:=A0Gregory Price <gourry@gourry.net>=0A=
Sent:=A0Saturday, February 7, 2026 10:18 AM=0A=
To:=A0Hongjian Fan <hongjian.fan@seagate.com>=0A=
Cc:=A0linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>=0A=
Subject:=A0Re: cgroup support for DCD=0A=
=A0=0A=
=0A=
=0A=
On Fri, Feb 06, 2026 at 06:00:38PM +0000, Hongjian Fan wrote:=0A=
> Hello,=0A=
>=0A=
> I would like to check if there is existing methods or any plan to support=
 allocating DCD extent through cgroup, which could enable DCD to the user a=
pplications without code change. This would also be a good way to use DCD i=
n container environment ( for example docker ) or other software already us=
eing cgroup for resource management.=0A=
>=0A=
> Use cases:=0A=
>=0A=
> 1) Expand the memory capacity=0A=
>=A0=A0=A0=A0=A0=A0 Creates a new cgroup=0A=
>=A0=A0=A0=A0=A0=A0 Add DCD extent(s) as system-ram private node(s) for thi=
s cgroup=0A=
>=A0=A0=A0=A0=A0=A0 Bind cgroup memory to dram nodes and DCD private nodes=
=0A=
>=A0=A0=A0=A0=A0=A0 Set memory capacity limit/tiering/numa balance policy/e=
tc=0A=
>=A0=A0=A0=A0=A0=A0 Start the application as normal / launch container with=
 this cgroup=0A=
>=A0=A0=A0=A0=A0=A0 Release DCD region=0A=
>=A0=A0=A0=A0=A0=A0 Remove cgroup=0A=
>=0A=
>=0A=
> 2) Increase system bandwidth=0A=
>=A0=A0=A0=A0=A0=A0 Creates a new cgroup=0A=
>=A0=A0=A0=A0=A0=A0 Add DCD extent(s) as system-ram private node(s) for thi=
s cgroup=0A=
>=A0=A0=A0=A0=A0=A0 Bind cgroup memory to dram nodes and DCD private nodes=
=0A=
>=A0=A0=A0=A0=A0=A0 Set weighted interleave numa bind policy and interleave=
 ratio=0A=
>=A0=A0=A0=A0=A0=A0 Start the application as normal / launch container with=
 this cgroup=0A=
>=A0=A0=A0=A0=A0=A0 Release DCD region=0A=
>=A0=A0=A0=A0=A0=A0 Remove cgroup=0A=
>=0A=
>=0A=
=0A=
What you're describing is using private nodes as non-private system-ram.=0A=
=0A=
Private nodes are intended for enlightened *kernel* services to provide=0A=
discrete interfaces to isolated memory, not for userland to build on top=0A=
of directly.=0A=
=0A=
You might, for example, provide memfd access to a private node, and=0A=
expose the file descriptor to a particular cgroup.=0A=
=0A=
What you're describing is just producing more normal sysram numa nodes=0A=
and providing them to isolated cgroups.=A0 This can, almost, already be=0A=
done with existing infrastructure.=0A=
=0A=
~Gregory=0A=
