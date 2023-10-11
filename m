Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC76C200AF
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E6598
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 07:06:23 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5F143Mhcz6K7Ft;
	Wed, 11 Oct 2023 22:06:00 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 15:06:21 +0100
Date: Wed, 11 Oct 2023 15:06:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Gregory Price <gregory.price@memverge.com>
CC: Yuquan Wang <wangyuquan1236@phytium.com.cn>, <dan.j.williams@intel.com>,
	<dimitrios.palyvos@zptcorp.com>, <linux-cxl@vger.kernel.org>
Subject: Re: Questions about the memory of CXL Type3 device offline
Message-ID: <20231011150620.0000212a@Huawei.com>
In-Reply-To: <ZSKu+bZfQmuTkrDH@memverge.com>
References: <20231010064648.1103157-1-wangyuquan1236@phytium.com.cn>
	<ZSKu+bZfQmuTkrDH@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, 8 Oct 2023 09:30:33 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Tue, Oct 10, 2023 at 02:46:48PM +0800, Yuquan Wang wrote:
> > On 2023-10-07 18:56,  gregory.price@memverge.com wrote:  
> > > because you likely have auto-online of new memory blocks sets to false.
> > > 
> > > use `daxctl list` and  `daxctl online-memory [dax-device]` to online the memory  
> > 
> > Thank you Gregory. It works! :)
> > 
> > BTW, I aslo did the same test in 'virt'(arm64) on Jonathan's development branch, 
> > however, it would automatically allcate CXL memory to numa node 0:
> >   
> 
> I haven't done any work with the arm machine.  Jonathan might have
> input.
> 
> But if the memory comes up, it's probably fine.  If the memory comes up
> automatically it's because you have auto-online turned on.

ARMs management of numa nodes is a bit simplistic currently as it doesn't
keep as much information around as x86 does.  That's something I've been
meaning to fix (in kernel) but not done so yet.

J
> 
> ~Gregory

