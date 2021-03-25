Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B5AC433DB
	for <linux-cxl@archiver.kernel.org>; Thu, 25 Mar 2021 08:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE19661A14
	for <linux-cxl@archiver.kernel.org>; Thu, 25 Mar 2021 08:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCYIM6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 25 Mar 2021 04:12:58 -0400
Received: from mail-bn7nam10on2045.outbound.protection.outlook.com ([40.107.92.45]:25356
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229461AbhCYIMh (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 25 Mar 2021 04:12:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZXOM3/q47zOvC0mRhyzpzCf9V2xoUtxiA9fckfSoG6WCC86aLUkWTVF+EJhjRcn9ukRGzA8jDLxZk2iY5k1LUEONDbqLh5XkA7oA9iDBibEVsbktgbpxEPVTT90yKwWvfpFV2ZGlWYV2lPXXVWIcssvsdvgWFth/HuQh0vu+UAF4DORdJC248J8IteeUfXKzrGlB8IZvYNs64xI9MKo3ccKEjkg49akzrAJmBdS4VKwk28ex3famhVroO2cRmtgHkmMfdue7zwgP/8Cj5KuWAbmuWqSXnR1WfyAS1ao/sbea98YdkHGK3ENoeZts6p8TDx7BSTKFaojM4QmvcSEsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlubUAYWqmztHHgj2Lyz2uhQkttbh7q4O6w/TYV82cY=;
 b=GIrBhIYDaCEkW6ZrtbWKRIcT6Z6gVQ7IC7xRBRpcYat3on4HPE/xgK7olRoIzH/EMCn4kWbWLro5XRn00Qvtfuaka0Y/MmE5p7u61qZLMiyHFPl0ZBixd3ROjnnueyJcyzOSBMiBqXMbdyGwCnyRCQC0S9KpGwK9UQwLktVt9N1cff6+VxslFL4fXALaL+Gv26lj89iamg3K0GLV5AWnw96hCOWK6dBUQfME7Oko7xPTWOJClokHGlHliW1yzGjIesVqLUhap+giE+G6EIyLcJc06wgANNfcs4OZIK1g/6Dqp/Py+iaZ8/JwNhKPutE8YH5+Jh9/JdYNOqldbLDz5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlubUAYWqmztHHgj2Lyz2uhQkttbh7q4O6w/TYV82cY=;
 b=AH++Vzb45TKz+qkQyswtiHud/Mr8/LBOHCyGR4T8iyWsKnG8p3mmePyRFv6PwhddCbXAgPOg9c3LpGZ4vdpvIOH0cWLeo+PNTFP+hc96EUcxj1AtLMTZYBuvulIBLg3gU7tWCAN+9OjkrvgEb2GyoN1DKBHF9T2NeM9Gw+Jme3Q=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by DM5PR12MB1401.namprd12.prod.outlook.com (2603:10b6:3:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 08:12:34 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::404b:b894:fe44:1878]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::404b:b894:fe44:1878%6]) with mapi id 15.20.3977.025; Thu, 25 Mar 2021
 08:12:34 +0000
Date:   Thu, 25 Mar 2021 09:12:27 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/mem: Force array size of mem_commands[] to
 CXL_MEM_COMMAND_ID_MAX
Message-ID: <YFxF6/LerP9OD8n9@rric.localdomain>
References: <20210324141635.22335-1-rrichter@amd.com>
 <20210324184257.GV3014244@iweiny-DESK2.sc.intel.com>
 <CAPcyv4gNvnMEL3kOjTYJjYG=7-N=jUUg-5+EqVszEHgSvF+XOw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gNvnMEL3kOjTYJjYG=7-N=jUUg-5+EqVszEHgSvF+XOw@mail.gmail.com>
X-Originating-IP: [77.191.18.210]
X-ClientProxiedBy: AM6P191CA0066.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::43) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (77.191.18.210) by AM6P191CA0066.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 08:12:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e6ab4708-036f-43a0-bf18-08d8ef65beb5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1401:
X-Microsoft-Antispam-PRVS: <DM5PR12MB14011F6A8712DBE9759BBF519C629@DM5PR12MB1401.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YaJ0Fv/gRO74Lh/SGXQBZ/gjf+ih9eHacg9VSEadeImG4B7em6MSTh48T3DVqnqdddZLCzNFpINRRXGo5mbfX163TRyZm6CPNPJgx8fIci0uZInJmL7PLoOTBatwdVhLvzr5NhRn33nAvOsQHJqnhjLcccINFvv4sktDni2rp2UcjlP9D7YVom0daDfSLvSUQmVQKvIDp2TI2kjs8IuOK6xVCDWURXJ0bPpUosikoYu5JvVhtcgfP7z8L62HIBF5o+RiYsOLfvslFNLpCntdmfkAa8FKz3ikNZu+Fyowf+R37rLexLELutNikJZn1mOEs6XG32ZEfK1naNH/+7ZiR1oGkgOWN0wjVSZFitj9THFHgSuN4rMRW7SauV5PrI+H1TQk1gBTVb5qysqr/WQf84SDq21PnTUF0zdlKnXOyw47TcRepqrn9Wj/H0oZOEFdJRBnnukASGrXPW3w3Nzk9Awdsv3L0SZ048qC+lZ+LHSRZBgAN2j185UHd7t1fsoOGzCfqOK41pIK3ooINokg/LOXODmxZrzAWje6mb9o3WMJWDwPxUBqSjs63X9RLOvwV5iqpWyC1o3YyLfXTJWrynYJeSFNo0bzvWRxz4g8fsFUnRdoGO3x1eOZrYt0bRZy6CXaZNNcSZ21tiRQAzGoZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(4744005)(53546011)(6666004)(6916009)(2906002)(6506007)(66556008)(66476007)(66946007)(83380400001)(8676002)(956004)(478600001)(8936002)(26005)(16526019)(9686003)(5660300002)(7696005)(55016002)(38100700001)(52116002)(316002)(54906003)(4326008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Zm6f6X7ECNhZ/HgFjnlHM+Wd6I49uu/7XCLNsaQ/jMYlCW8HwwHlQ1rcp2YM?=
 =?us-ascii?Q?M7qQtWqMJwa4FWI12R+xlueuO6wgenQmCEqQPOkDJlQDHmRmHBHjxQLEC4L/?=
 =?us-ascii?Q?otoC9scknne9YIXwNpRH8o1HQ83Dh35prMp6nJLhOiwbVrgbMxnBxEtCqYTb?=
 =?us-ascii?Q?Kls1wpPiQB2G0UFb61aV3mngh/onAEnBAkz+0fOdYOR4o0CuK+YzdHnXS04x?=
 =?us-ascii?Q?dcbHVkOuXQ1L3TgBeC45WKCEZ3S8gagqvdaULF0qqSXvp0aIgajq3RuRQC6Y?=
 =?us-ascii?Q?61pK2XaiVKW0bjD3k/RLfZK0z+3F57bxhtQAKwRvUT0sESoP54xlZaujMSjd?=
 =?us-ascii?Q?SGiOkLiMBRrSZ+PfdfT6NBgaVb/GqG2OTeRQC2wHrAAWCLv1wj+gTrrUcOar?=
 =?us-ascii?Q?itkMewJVKC5G86kv/jj/popFo/BrJA09PJnMin5qnr/284XiTDVmUg7uu5Ea?=
 =?us-ascii?Q?H9aL0XAmzB4SElHY7bDMWCdonuibIL+gIoP/V4twEx1iNs3JQIaX58HyjNjo?=
 =?us-ascii?Q?Sb6r79U3w3TLXEVoAo/pfa1vEgeqxOLDbE68jd2rYjkUqickGQbRo2dU8CJr?=
 =?us-ascii?Q?U/KN8qgJG+dM0QjET6zKgK/6AuBuK7oMTtoMLeIgXQYMe/0aG9QF5bInPuKK?=
 =?us-ascii?Q?Zbjjg11hlYZb0PXYr31jYXnsBcI9ExlDbU06DF7zO5HVFzroiGKPaEfQKJST?=
 =?us-ascii?Q?IRHPLZBjS1nABPm7AHDMSgONl7J5zLaleELp732IDnmfC4qoiYTeOmlVyh38?=
 =?us-ascii?Q?IfkF69qc3db6ybs+eLEsN6uuKxBK4eZfWSv21fjPZ0E9SudC0eZ+KbVm80tW?=
 =?us-ascii?Q?Mnwb3kZyomcZh5GnD9pFSHPdqmkgN2vO57WsXtptBivg5niaB69o50MwTJgt?=
 =?us-ascii?Q?4CML+TPzFhjS5cTeABNNr0QZuLf5SpbKkzG468BsVH1WVs9H14RKGRtkDUJr?=
 =?us-ascii?Q?r7u905GKbtcMwUoBGFKD1msDP5r6YkzbOkbmBcAKLl8WeJ41gGLKkR0vbLgW?=
 =?us-ascii?Q?jm2nU6KB4cDvS5quDVzNmjvqBNybrz+ogY+IkeSBosF7Hv4sTEAkBxSC98hS?=
 =?us-ascii?Q?+YdG0R+wzX/g7URVKnWyMcTLkCOm0uVphvt12JAuXUh9BxB5Nu9CvD7RpEhX?=
 =?us-ascii?Q?fBK+3JfQY8K0wdIJUfNTDp7nMj0NWbMe3p+jh4EZ7MKf8MFVDUILeyMvW2RM?=
 =?us-ascii?Q?p7ziK0eXFJdl/qz2VCzMoQEVKD80q5X1406ugeU3Px3/3ry9zcopXlSaooQ1?=
 =?us-ascii?Q?A2PeMhkc2f2iPShweweKXoOJhqgtv/A55pvROgRSJF2+1V1SnawV5zelNNdn?=
 =?us-ascii?Q?xrW6QKXo9jj5JyKhbbPOEcn2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ab4708-036f-43a0-bf18-08d8ef65beb5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 08:12:34.4731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvy6KyIKR815TrmhKFH57X3+PVBVssaavA34IeanQtqGithkuObBy63V7SHl8nfM3crZ13Vkjq/bKjsdiDoIsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1401
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 24.03.21 12:08:20, Dan Williams wrote:
> On Wed, Mar 24, 2021 at 11:43 AM Ira Weiny <ira.weiny@intel.com> wrote:

> > Can't we use ARRAY_SIZE?
> 
> An ARRAY_SIZE() check in cxl_validate_cmd_from_user() would work too,
> but it wouldn't give the compiler protection that Robert mentions for
> going the other way where mem_commands tries to add an entry that is
> out of bounds relative to CXL_CMDS.

I was considering that too. Another reason apart from above was to
treat 'holes' in the array caused by #ifdefs the same regardless its
position in the array. Thus, all should show up as being zeroed
instead of cutting those at the end from the array.

Thanks for applying,

-Robert
