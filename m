Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456223C196E;
	Thu, 22 Jan 2026 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118077; cv=none; b=p9bv1i7V9+hTqegbkBMW/26qltv+j2/1oaM9k0H17CwTVfSvrm5kxec8SoofPu5br4Bgh8cBzDZtiYxNTnPG/asHlAWZJVPAI6LswzC+CBnu5IuzxjEpcAgqnAPxM4Tig1d9jzKNyNMyjx8xDirULYng4HsRIH//FJWej+jFwew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118077; c=relaxed/simple;
	bh=o3gdWNkDSd9Vm/DMgr4/ykIAOvt43+NsJA/Imw15e/A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Gj/WxZidYAT7bv4N9ogHx7SGTkmiICpSeorLW++5Y41fjPdxnB6CBSBb7DIUv79LHwOtLyzHaQAVTBfAqABt/mMpvpASi5KL7J4Vtj/3zVv6zE3lsLLoBiMTWN5bkBtlmh68XM2diae/sBCLbpVLZK9msCTjC00qHvSmFml+6mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nbhvWI6F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nbhvWI6F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482E1C116C6;
	Thu, 22 Jan 2026 21:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769118076;
	bh=o3gdWNkDSd9Vm/DMgr4/ykIAOvt43+NsJA/Imw15e/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nbhvWI6FsmrV2v6DkoSqN8213V2yIRhOd6eP75LypoUaN54UBoDiDxVp1akq7FG3f
	 CVLIelPV0CkF4x7Juc3HDczRCXMl0AOZY4EUYaiK0pNhQfi7cbwzUhOkV6AnNppJ9U
	 SqiE6hXL+nm2nlnc5o4hmp73evXdLpeOeMX2qi64=
Date: Thu, 22 Jan 2026 13:41:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Matthew Brost
 <matthew.brost@intel.com>, Zi Yan <ziy@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Alistair Popple
 <apopple@nvidia.com>, Francois Dugast <francois.dugast@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, adhavan
 Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Lyude Paul <lyude@redhat.com>, Danilo Krummrich
 <dakr@kernel.org>, David Hildenbrand <david@kernel.org>, Oscar Salvador
 <osalvador@suse.de>, Leon Romanovsky <leon@kernel.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-mm@kvack.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 1/5] mm/zone_device: Reinitialize large zone device
 private folios
Message-Id: <20260122134114.a04ddf4c34a4b926d057032f@linux-foundation.org>
In-Reply-To: <626c34fc-34df-4629-baf3-fbebc9abafbb@nvidia.com>
References: <eb94d115-18a6-455b-b020-f18f372e283a@nvidia.com>
	<aWsdv6dX2RgqajFQ@lstrano-desk.jf.intel.com>
	<4k72r4n5poss2glrof5fsapczkpcrnpokposeikw5wjvtodbto@wpqsxoxzpvy6>
	<20260119142019.GG1134360@nvidia.com>
	<96926697-070C-45DE-AD26-559652625859@nvidia.com>
	<20260119203551.GQ1134360@nvidia.com>
	<ef6ef1e2-25f1-4f1b-a8d4-98c0d7b4ad0c@nvidia.com>
	<EE2956E3-CCEA-4EF9-A1A4-A483245091FC@nvidia.com>
	<20260120135340.GA1134360@nvidia.com>
	<F7E3DF24-A37B-40A0-A507-CEF4AB76C44D@nvidia.com>
	<aXHPkQfwhMHU/oP6@lstrano-desk.jf.intel.com>
	<9077ab5b-f2c8-4c8d-8441-631e7c2cf384@suse.cz>
	<626c34fc-34df-4629-baf3-fbebc9abafbb@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 22 Jan 2026 20:10:44 +1100 Balbir Singh <balbirs@nvidia.com> wrote:

> >> - Intel has demonstrated that this works and is still getting blocked.
> >>
> >> - This entire thread is about a fixes patch for large device pages.
> >>   Changing prep_compound_page is completely out of scope for a fixes
> >>   patch, and honestly so is most of the rest of what’s being proposed.
> > 
> > FWIW I'm ok if this lands as a fix patch, and perceived the discussion to be
> > about how refactor things more properly afterwards, going forward.
> > 
> 
> I've said the same thing and I concur, we can use the patch as-is and
> change this to set the relevant identified fields after 6.19

So the plan is to add this patch to 6.19-rc and take another look at
patches [2-5] during next -rc cycle?

I think the plan is to take Matthew's work via the DRM tree?  But if people
want me to patchbunny this fix then please lmk.

I presently have

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Francois Dugast <francois.dugast@intel.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>

If people wish to add to this then please do so.

I'll restore this patch into mm.git's hotfix branch (and hence
linux-next) because testing.
