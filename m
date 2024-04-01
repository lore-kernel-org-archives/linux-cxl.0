Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD3279DD
	for <linux-cxl@vger.kernel.org>; Mon,  1 Apr 2024 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711951397; cv=fail; b=kSjTHxL3N3jzBegt3gg4lAli3p8T3Jfksxp/aXGUVLgOiwJ8GfZEBlyXhFwIBPmVlGQ9TJNZj7Fd1QRA1t/MLtBESJmkTkhsh0m/mdKl2bL8IkseAg4TltLToIAalX5p9et4zFCsArjAiOQcjJ1UiTb7FkKu1op8K+uouHS+52I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711951397; c=relaxed/simple;
	bh=HpJcBjbmLfdGZOKPihdyrzkeSBoMU89fOtfPkA+ibV8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cjap0tXjGLnE5+V7+xcEuHXmtucaM4yAcaoKsR3O5vQWZ4HbC8wpU2uEeVHSk0BofkThq2crBmPHiNwHziULhCqfa9r8KmkK/h7jFmqypq5Jj/IWNrjJuieoahWzi9i0X8GZLBdL5yO8vQgrauO7OZ9zMqbKDhQGi4Ii72TAv+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=PzbUp2Jd; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="PzbUp2Jd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLRIMPwsoAdVG6zAaYOScOVh5XZfleL/4C8iHt3WWh96aehkDIu1UiPTPVgB+tDxlg8uJAtmz9uNZkKagiK2PTCM/qM5zxSjfO+JJ0vdr3VUvCfw4XDKgK5VCAb4+Qc3R+vvGeRuWsQOeTW91Ny4ruDw7RiImJqYB5SN7hCwdFBtnDW9/6rZozV9LuJ4C3+nZi1gnpN5X15nYiUF2qmHDQHC9pAhb7qzsjoyxuQjYH2+SeUFuUufFqiN1Xcj4Y4ZYknF9zAdeWXDjTctMyUMrjW8c3DfgAjm6uXJ4JM3D4E95DJWEZYEBRdeGNDm3pHvvG9NOrScNBkmBFvAlNtHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXgD4CXCAbF9TXsuYpA4TZpKxal7v7AwEOuftCMiIn8=;
 b=lrcev5QGFwpD2ygwm2JCoqgWuA7ocTCn11+SoGSApWo5FN8HvYd6O9/ggz6xmtcFm8/+FTxdMLu7Zg4NLv571zGYH5XL0Nvo5Owwp3Xj6WKfRmZ1FoQJ+mLJqoBMwDDlkMGBCktwCSWnsmWkN96lkbxpA6PetQgGaAPCnO1vRRcEpd+2GUTOVcU3LmVZzLY0rVI9vFXED0V8cX3V8Q5+GtO9AEVFbAVzq1u+5z9I6tNQG9DyZb2mnAgsKg8JHh1Ioa1AmoF2f0+dPQPsC+QU2UDFMg0mh1IGiVkR5mGlFUOcl4Inp4dE3K40chyJ289uC6gaxQiZzB1NwbjSonHxfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXgD4CXCAbF9TXsuYpA4TZpKxal7v7AwEOuftCMiIn8=;
 b=PzbUp2JdRs/7jeMnEC6rssZzqnoV6ZwNRCStl9MWyZ8TAHwQv+3UztVSmUFMTa23c1az8Z1WCnW7OdmK+3gOK0D9Y+gv4Uzc5aQZeJl8EJdjBr0l2+/o419e024vUKCiW2DuKOSlyKoqTpxaJ1+9O7lOcd74EQyJtdci4F1Cr+DQ3nZetnjwzKcqd5p0Hz64EGMy+SOKQ18/LnOfgcC6kAn7kJMywe1X+aHVFx5IRRQwzTTmXpcXh/d9oU15X7XR1lwt94mjsakDd47oXQPpFKX3FtWCXPRg9juR5l65E5thTrlS1eatIt/PyYN5pkvM4ISwMQqgYa+DT749579aAw==
Received: from DS7PR03CA0049.namprd03.prod.outlook.com (2603:10b6:5:3b5::24)
 by SJ0PR08MB8239.namprd08.prod.outlook.com (2603:10b6:a03:43d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 06:03:09 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::d7) by DS7PR03CA0049.outlook.office365.com
 (2603:10b6:5:3b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 1 Apr 2024 06:03:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 06:03:08 +0000
Received: from BOW36EX19A.micron.com (137.201.85.33) by BOW36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 1 Apr 2024
 00:03:07 -0600
Received: from BOW36EX19A.micron.com ([fe80::abcd:e67:5521:a5ef]) by
 BOW36EX19A.micron.com ([fe80::abcd:e67:5521:a5ef%8]) with mapi id
 15.02.1544.004; Mon, 1 Apr 2024 00:03:07 -0600
From: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>
To: Dan Williams <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"john@jagalactic.com" <john@jagalactic.com>, Eishan Mirakhur
	<emirakhur@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, Ravis OpenSrc
	<Ravis.OpenSrc@micron.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>
Subject: RE: [EXT] RE: [PATCH v3 0/2] Add log related mailbox commands
Thread-Topic: [EXT] RE: [PATCH v3 0/2] Add log related mailbox commands
Thread-Index: AQHadRXMcEM/HRcqCEiGD+FIzQ19R7FLJ34AgAfhsMA=
Date: Mon, 1 Apr 2024 06:03:07 +0000
Message-ID: <38d0842e1f774c82b2f8f58f4d7ab07f@micron.com>
References: <20240313071218.729-1-sthanneeru.opensrc@micron.com>
 <66035c2e8ba17_770232948b@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <66035c2e8ba17_770232948b@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mt-whitelisted: matched
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|SJ0PR08MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a178fe5-9e73-47fc-bb9d-08dc521167c3
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z0u8NfsW2KjX/5PUQF0D7hCfJ3ZdRyMV4iyuuRNzIynxue6e/Fls+i0z62XKbB8GsxT8Av7Uo55WRV0yQfIPBHwfnZ3WMZQFzRGpd7xpJ+2u7fkNSu9LcjkSXc+SUlkWKJgC8eAcgfcK2jfFNiC/5gc9rwhwVJrqrTIxZuyV4KU5/4/LDBxD6yo3LRwXLNDEyzH5EQ90VzMms84o28SW1fOfTgDDrSMjW0sfiYDm33OJjegIXriKQTF6cJM2ZQ4h3FsRLKpkFrpSIoo29oC9VHwQ7X9XaoqvEbpNxelGXQh8/VMI/E4kQwHLfLwizg7p+pSdV6TJx/l8WW5aKfFutySnwG+UosLoThQhImpA/iKwLshN1LyNMiIqRc5ONCoBg9cgZYQnLHQ2TKU9GkMBER2SjGo3uMoPlG+sELP0MnHEP//bxFAcD2JpbpI7rvBQz//nIEkDi9RNQbF7SXLSjAcVscZiAnOdB2kCc6Rnm7gpViQKp5YUSC2m0hdnYeSrkGkRuZnimTWLANVYIMG3fTLCy17W4qbp6zfKItrWFCN9qokrBnqxZcuTXiRQx7O0b+LgMUnGzGFDYKitRjblgWqywd5WNCK+tcG2de8pCnTvZozArcKoTwESPK18V9OdBkbylrSXoi/xDur31Lmqct7+M72BpPo+zmopz3mdlM6J7ZMMp3EKnjFe5Uu1nIcQLCLOJuWe5EsTy0aidfTcwg==
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 06:03:08.7632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a178fe5-9e73-47fc-bb9d-08dc521167c3
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB8239



>-----Original Message-----
>From: Dan Williams <dan.j.williams@intel.com>
>Sent: Wednesday, March 27, 2024 5:07 AM
>To: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>; linux-
>cxl@vger.kernel.org
>Cc: Jonathan.Cameron@huawei.com; dan.j.williams@intel.com;
>john@jagalactic.com; Eishan Mirakhur <emirakhur@micron.com>; Ajay Joshi
><ajayjoshi@micron.com>; Ravis OpenSrc <Ravis.OpenSrc@micron.com>;
>Srinivasulu Thanneeru <sthanneeru@micron.com>
>Subject: [EXT] RE: [PATCH v3 0/2] Add log related mailbox commands
>
>CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you
>recognize the sender and were expecting this message.
>
>
>sthanneeru.opensrc@ wrote:
>> From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
>>
>> Add support to expose following mailbox commands to userspace
>> for clearing and populating the Vendor debug log in certain
>> scenarios, allowing for the aggregation of results over time.
>>
>> 1. CXL r3.1 8.2.9.5.3 Get Log Capabilities.
>> 2. CXL r3.1 8.2.9.5.4 Clear Log commands.
>> 3. CXL r3.1 8.2.9.5.6 Get Supported Logs Sub-List.
>>
>> ---
>> Changes in v3:
>> - 'Component State Dump log' has several caveats for ioctl()
>>    not being a suitable ABI as pointed in v2.(Dan Williams)
>> - Remove Component State Dump from Clear log filter.
>> - Implement a seperate patch(yet to do) to address issues as pointed in =
v2.
>
>Circling back to this question... I had overlooked the fact that in v3.1
>the "Request Abort Background Operation" command was added (8.2.9.1.5).
>With that the kernel can safely support background commands with
>indefinite residency. So as long as the device supports that command and
>advertises that Log populate requests can be cancelled then we can build
>a facility to cancel any user-submitted background commands when a
>kernel internal need for the background command slot arises.

I don't have the access to test "Request Abort Background Operation."
Previously, we posted RFC for default time for background operations.
https://lore.kernel.org/linux-mm/20240207105349.301-1-sthanneeru.opensrc@mi=
cron.com/

 Could you please guide me on how to proceed with this current patch series=
?
